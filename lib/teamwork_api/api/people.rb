# frozen_string_literal: true

module TeamworkApi
  module API
    # client methods for People
    # https://developer.teamwork.com/projects/people
    module People
      OPTIONAL_GET_ATTRIBUTES = [
        :project_id,
        :page,
        :page_size,
        :group_by_company,
        :sort,
        :sort_order,
        :full_profile
      ].freeze
      OPTIONAL_UPDATE_ATTRIBUTES = [
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
      ].freeze

      def person(person_id)
        response = get "/people/#{person_id}.json"
        response.body['person']
      end

      def people(args = {})
        args = API.params(args).optional(*OPTIONAL_GET_ATTRIBUTES).to_h
        response = get '/people.json', args
        response.body['people']
      end

      def add_person_to_project(project_id, person_id)
        response =
          put "projects/#{project_id}/people.json",
              add: { userIdList: person_id }
        response.body['STATUS']
      end

      def set_permissions(project_id, person_id, args)
        args = API.params(args).optional(*OPTIONAL_UPDATE_ATTRIBUTES).to_h
        response =
          put "projects/#{project_id}/people/#{person_id}.json",
              permissions: args
        response.body
      end
    end
  end
end
