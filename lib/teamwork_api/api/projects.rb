module TeamworkApi
  module API
    module Projects
      def create_project(args)
        args =
          API.params(args)
             .required(:name)
             .default('category-id': '0')
             .optional(
               :description,
               :start_date,
               :end_date,
               :company_id,
               :new_company,
               :'harvest-timers-enabled',
               :tags,
               :reply_by_email_enabled,
               :privacy_enabled
             ).to_h

        response = post 'projects.json', project: args
        response['id']
      end

      def update_project(project_id, args)
        args =
          API.params(args)
             .optional(
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
             ).to_h

        response = put "projects/#{project_id}.json", project: args
        response['id']
      end

      def project(project_id, args = {})
        if args.present?
          args = { project: args }
        else
          args = {}
        end
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
