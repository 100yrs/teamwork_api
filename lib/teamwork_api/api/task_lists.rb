# frozen_string_literal: true

module TeamworkApi
  module API
    # Client methods for TaskLists
    # https://developer.teamwork.com/projects/task-lists
    module TaskLists
      def create_task_list(project_id, args)
        args =
          API.params(args)
             .required(:name)
             .optional(
               :private,
               :pinned,
               :'milestone-id',
               :description,
               :'todo-list-template-id',
               :'todo-list-template-start-date',
               :'todo-list-template-keep-off-weekends',
               :'todo-list-template-assignments'
             ).to_h

        response = post "projects/#{project_id}/tasklists.json", tasklist: args
        response['TASKLISTID']&.to_i
      end

      # def update_task_list(task_list_id, args)
      # end

      def task_list(task_list_id)
        response = get "/tasklists/#{task_list_id}.json"
        response.body['todo-list']
      end

      def task_lists
        response = get '/tasklists.json'
        response.body['tasklists']
      end

      def delete_task_list(task_list_id)
        delete "/tasklists/#{task_list_id}.json"
      end
    end
  end
end
