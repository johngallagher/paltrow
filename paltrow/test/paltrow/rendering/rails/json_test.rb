module Paltrow
  module Rendering
    module Rails
      class JSONTest < Minitest::Test
        def test_renders_view_as_json
          controller = spy(:controller)
          view = View.new(
            controller: "tasks",
            action: "edit",
            locals: {
              name: "Do the laundry",
              completed: false
            }
          )

          JSON.new.call(
            controller: controller,
            view: view
          )

          expect(controller).to have_received(:render).with(
            json: {
              name: "Do the laundry",
              completed: false
            }
          )
        end

        def test_renders_alert_view_with_message_and_unprocessable_entity
          controller = spy(:controller)
          view = View.new(
            controller: "tasks",
            action: "edit",
            locals: {
              name: "Do the laundry",
              completed: false
            }
          ).with_alert("An alert")

          JSON.new.call(
            controller: controller,
            view: view
          )

          expect(controller).to have_received(:render).with(
            json: {
              error: "An alert"
            },
            status: :unprocessable_entity
          )
        end
      end
    end
  end
end
