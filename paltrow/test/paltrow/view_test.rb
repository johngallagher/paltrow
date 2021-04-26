module Paltrow
  class ViewTest < Minitest::Test
    def test__creating_with_locals_controller_and_actions
      edit_tasks_view = View.new(
        controller: "tasks",
        action: "edit",
        locals: {
          name: "Do the laundry",
          completed: false
        }
      )
      assert_equal "tasks", edit_tasks_view.controller
      assert_equal "edit", edit_tasks_view.action
      assert_equal ({name: "Do the laundry", completed: false}), edit_tasks_view.locals
    end

    def test__creating_with_notice
      view = View.new(
        controller: "tasks",
        action: "edit",
        message: {
          text: "A notice"
        }
      )
      assert_equal "A notice", view.notice
      assert_equal "", view.alert
    end

    def test__creating_with_alert
      view = View.new(
        controller: "tasks",
        action: "edit",
        message: {
          text: "An alert",
          success: false
        }
      )
      assert_equal "", view.notice
      assert_equal "An alert", view.alert
    end
  end
end
