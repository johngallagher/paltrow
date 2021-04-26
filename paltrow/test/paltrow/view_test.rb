module Paltrow
  class ViewTest < Minitest::Test
    def test__creating_with_locals_controller_and_actions__returns_attributes
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
  end
end
