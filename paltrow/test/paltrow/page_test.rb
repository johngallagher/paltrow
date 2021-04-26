module Paltrow
  class PageTest < Minitest::Test
    def test__to_params_merges_controller_action_resource_ids_and_query
      edit_tasks_view = Page.new(
        controller: "tasks",
        action: "edit",
        resource_ids: {
          id: "task-123",
          project_id: "project-123"
        },
        query: {
          completed: false
        }
      )
      assert_equal "tasks", edit_tasks_view.controller
      assert_equal "edit", edit_tasks_view.action
      assert_equal ({
        controller: "tasks",
        action: "edit",
        id: "task-123",
        project_id: "project-123",
        completed: false
      }), edit_tasks_view.to_params
    end
  end
end
