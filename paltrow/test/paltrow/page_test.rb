module Paltrow
  class PageTest < Minitest::Test
    def test__to_params_merges_resource_action_resource_ids_and_query
      edit_tasks_view = Page.new(
        resource: "tasks",
        action: "edit",
        resource_ids: {
          id: "task-123",
          project_id: "project-123"
        },
        query: {
          completed: false
        }
      )
      assert_equal "tasks", edit_tasks_view.resource
      assert_equal "edit", edit_tasks_view.action
      assert_equal ({
        resource: "tasks",
        action: "edit",
        id: "task-123",
        project_id: "project-123",
        completed: false
      }), edit_tasks_view.to_params
    end

    def test__creating_with_notice_builder
      page = Page.new(
        resource: "tasks",
        action: "edit"
      ).with_notice("A notice")

      assert_equal "A notice", page.notice
      assert_equal "", page.alert
    end

    def test__creating_with_alert_builder
      page = Page.new(
        resource: "tasks",
        action: "edit"
      ).with_alert("An alert")

      assert_equal "", page.notice
      assert_equal "An alert", page.alert
    end

    def test__creating_with_notice
      page = Page.new(
        resource: "tasks",
        action: "edit",
        message: {
          text: "A notice"
        }
      )
      assert_equal "A notice", page.notice
      assert_equal "", page.alert
    end

    def test__creating_with_alert
      page = Page.new(
        resource: "tasks",
        action: "edit",
        message: {
          text: "An alert",
          success: false
        }
      )
      assert_equal "", page.notice
      assert_equal "An alert", page.alert
    end
  end
end
