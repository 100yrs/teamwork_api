# frozen_string_literal: true

module TeamworkApi
  module API
    # Client methods for Projects
    # https://developer.teamwork.com/projects/projects
    module Projects
      OPTIONAL_GET_ATTRIBUTES = [
        :status,
        :updated_after_date,
        :order_by,
        :created_after_date,
        :created_after_time,
        :cat_id,
        :include_people,
        :include_project_owner,
        :page,
        :page_size,
        :order_mode,
        :only_starred_projects,
        :company_id,
        :project_owner_ids,
        :search_term,
        :get_deleted,
        :include_tags,
        :user_id,
        :updated_after_date_time
      ].freeze
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
             .optional(*OPTIONAL_CREATE_ATTRIBUTES)
             .to_h

        response = post 'projects.json', project: args
        response['id']&.to_i
      end

      def update_project(project_id, args)
        args = API.params(args).optional(*OPTIONAL_UPDATE_ATTRIBUTES).to_h

        put "projects/#{project_id}.json", project: args
      end

      def project(project_id, args = {})
        args = { project: args } unless args.empty?
        response = get "/projects/#{project_id}.json", args
        response.body['project']
      end

      def projects(args = {})
        args = API.params(args).optional(*OPTIONAL_GET_ATTRIBUTES).to_h
        response = get '/projects.json', args
        response.body['projects']
      end

      def delete_project(project_id)
        delete "/projects/#{project_id}.json"
      end
    end
  end
end
