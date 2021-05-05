module Paltrow
  module Rendering
    module Rails
      class TemplateTest < Minitest::Test
        def test__given_resource_and_action__then_renders_template_with_that_name
          controller = spy(:controller)
          view = build(
            :view,
            resource: "tasks",
            action: "edit",
            locals: {
              name: "Do the laundry",
              completed: false
            }
          )

          Template.new.call(
            handler: controller,
            view: view
          )

          expect(controller).to have_received(:render).with(
            template: "tasks/edit",
            locals: {
              name: "Do the laundry",
              completed: false
            }
          )
        end
      end
    end
  end
end
