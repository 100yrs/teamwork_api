# frozen_string_literal: true

module TeamworkApi
  module API
    module People
      def add_person_to_project(project_id, person_id)
        response =
          put "projects/#{project_id}/people.json",
              { add: { userIdList: person_id } }
        response.body['STATUS']
      end

      def set_permissions(project_id, person_id, args)
        args =
          API.params(args)
             .optional(
               :'edit-all-tasks',
               :'view-messages-and-files',
               :'view-tasks-and-milestones',
               :'view-time',
               :'view-notebooks',
               :'view-risk-register',
               :'view-invoices',
               :'view-links',
               :'view-links',
               :'add-tasks',
               :'add-milestones',
               :'add-taskLists',
               :'add-messages',
               :'add-files',
               :'add-time',
               :'add-notebooks',
               :'add-links',
               :'set-privacy',
               :'set-privacy',
               :'is-observing',
               :'can-be-assigned-to-tasks-and-milestones',
               :'project-administrator',
               :'add-people-to-project'
             ).to_h

        response =
          put "projects/#{project_id}/people/#{person_id}.json",
              permissions: args
        response.body
      end
    end
  end
end
