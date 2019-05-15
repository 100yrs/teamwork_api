# frozen_string_literal: true

module TeamworkApi
  module API
    # client methods for ProjectOwner. Note that there isn't a specific
    # ProjectOwner endpoint and these happen via the project
    # https://developer.teamwork.com/projects/project-owner
    module ProjectOwner
      def project_owner(project_id)
        response = get "projects/#{project_id}.json",
                       project: { include_project_owner: true }
        response[:project][:owner]
      end

      # This doesn't seem to work. Response is OK, but owner not set
      def set_project_owner(project_id, args)
        args =
          API.params(args)
             .required(:project_owner_id)
             .to_h

        response = put "projects/#{project_id}.json", project: args
        response.body['STATUS']
      end
    end
  end
end
