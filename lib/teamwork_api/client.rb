# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'
require 'uri'
require 'teamwork_api/version'
require 'teamwork_api/api/companies'
require 'teamwork_api/api/people'
require 'teamwork_api/api/projects'
require 'teamwork_api/api/project_owner'
require 'teamwork_api/api/task_lists'

module TeamworkApi
  # The main Teamwork client object
  class Client
    attr_accessor :api_key
    attr_reader :host

    include TeamworkApi::API::Companies
    include TeamworkApi::API::People
    include TeamworkApi::API::Projects
    include TeamworkApi::API::ProjectOwner
    include TeamworkApi::API::TaskLists

    def initialize(host, api_key = nil)
      raise ArgumentError, 'host needs to be defined' if
        host.nil? || host.empty?

      @host         = host
      @api_key      = api_key
      @use_relative = check_subdirectory(host)
    end

    def connection_options
      @connection_options ||= {
        url: @host,
        headers: {
          accept: 'application/json',
          user_agent: user_agent
        }
      }
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      response = request(:post, path, params)
      case response.status
      when 200, 201, 204
        response.body
      else
        raise TeamworkApi::Error, response.body
      end
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def patch(path, params = {})
      request(:patch, path, params)
    end

    def user_agent
      @user_agent ||= "TeamworkApi Ruby Gem #{TeamworkApi::VERSION}"
    end

    private

    def connection
      @connection ||= Faraday.new connection_options do |conn|
        # Follow redirects
        conn.use FaradayMiddleware::FollowRedirects, limit: 5
        # Use JSON for request
        conn.request :json
        # Allow uploading of files
        conn.request :multipart
        # Convert request params to "www-form-encoded"
        conn.request :url_encoded
        # Log requests and responses to $stdout
        # conn.response :logger
        # Parse responses as JSON
        conn.use FaradayMiddleware::ParseJson, content_type: 'application/json'
        # Use Faraday's default HTTP adapter
        conn.adapter Faraday.default_adapter
      end
    end

    def request(method, path, params = {})
      connection.headers[:cache_control] = 'no-cache'
      connection.basic_auth(api_key, '')
      response =
        connection.send(method.to_sym, request_path(path), params_hash(params))
      handle_error(response)
      response.env
    rescue Faraday::Error::ClientError, JSON::ParserError
      raise TeamworkApi::Error
    end

    def handle_error(response)
      body = response.env[:body]
      env = response.env

      case response.status
      when 403
        raise TeamworkApi::UnauthenticatedError.new(body, env)
      when 404, 410
        raise TeamworkApi::NotFoundError.new(body, env)
      when 422
        raise TeamworkApi::UnprocessableEntity.new(body, env)
      when 429
        raise TeamworkApi::TooManyRequests.new(body, env)
      when 500...600
        raise TeamworkApi::Error, body
      end
    end

    def check_subdirectory(host)
      URI(host).request_uri != '/'
    end

    def request_path(path)
      @use_relative ? path.sub(%r{^\/}, '') : path
    end

    def params_hash(params)
      unless params.is_a?(Hash)
        params = params.to_h if params.respond_to? :to_h
      end
      params
    end
  end
end
