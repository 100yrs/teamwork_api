# frozen_string_literal: true

module TeamworkApi
  module API
    # client methods for Companies
    # https://developer.teamwork.com/projects/companies
    module Companies
      def company(company_id)
        response = get "/companies/#{company_id}.json"
        response.body['company']
      end

      def companies
        response = get '/companies.json'
        response.body['companies']
      end

      def company_by_name(company_name)
        companies.select { |c| c['name'] == company_name }.first
      end
    end
  end
end
