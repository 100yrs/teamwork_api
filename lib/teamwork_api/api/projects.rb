# frozen_string_literal: true

module TeamworkApi
  module API
    # client methods for Projects
    # https://developer.teamwork.com/projects/projects
    module Projects
      OPTIONAL_CREATE_ATTRIBUTES = [
        :description,
        :start_date,
        :end_date,
        :company_id,
        :new_company,
        :'harvest-timers-enabled',
        :tags,
        :reply_by_email_enabled,
        :privacy_enabled
      ].freeze
      OPTIONAL_UPDATE_ATTRIBUTES = [
        :name,
        :description,
        :start_date,
        :end_date,
        :company_id,
        :new_company,
        :status,
        :'category-id',
        :'harvest-timers-enabled',
        :tags,
        :reply_by_email_enabled,
        :privacy_enabled,
        :'use-tasks',
        :'use-messages',
        :'use-time',
        :'use-risk-register',
        :'use-billing',
        :'use-milestones',
        :'use-files',
        :'use-notebook',
        :'use-links',
        :default_privacy
      ].freeze

      def create_project(args)
        args =
          API.params(args)
             .required(:name)
             .default('category-id': '0')
             .optional(OPTIONAL_CREATE_ATTRIBUTES)
             .to_h

        response = post 'projects.json', project: args
        response['id']
      end

      def update_project(project_id, args)
        args = API.params(args).optional(OPTIONAL_UPDATE_ATTRIBUTES).to_h

        response = put "projects/#{project_id}.json", project: args
        response['id']
      end

      def project(project_id, args = {})
        args = (args.present? ? { project: args } : {})
        response = get "/projects/#{project_id}.json", args
        response.body['project']
      end

      def projects
        response = get '/projects.json'
        response.body['projects']
      end

      def delete_project(project_id)
        delete "/projects/#{project_id}.json"
      end
    end
  end
end
