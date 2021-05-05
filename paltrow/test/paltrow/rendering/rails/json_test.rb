module Paltrow
  module Rendering
    module Rails
      class JSONTest < Minitest::Test
        def test_renders_view_as_json
          handler = spy(:handler)
          view = build(
            :view,
            locals: {
              name: "Do the laundry",
              completed: false
            }
          )

          JSON.new.call(
            handler: handler,
            view: view
          )

          expect(handler).to have_received(:render).with(
            json: {
              name: "Do the laundry",
              completed: false
            }
          )
        end

        def test_renders_alert_view_with_message_and_unprocessable_entity
          handler = spy(:handler)
          view = build(
            :view,
            locals: {
              name: "Do the laundry",
              completed: false
            },
            message: {
              text: "An alert",
              success: false
            }
          )

          JSON.new.call(
            handler: handler,
            view: view
          )

          expect(handler).to have_received(:render).with(
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
