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

        def test__given_view_with_notice__then_sets_notice_on_flash_now
          flash_now = instance_spy(Hash)
          controller = spy(:controller, flash: OpenStruct.new(now: flash_now))
          view = build(
            :view,
            message: {
              text: "A notice",
              success: true
            }
          )

          Template.new.call(
            handler: controller,
            view: view
          )

          expect(flash_now).to have_received(:[]=).with(
            :notice,
            "A notice"
          )
        end

        def test__given_view_with_alert__then_sets_alert_on_flash_now
          flash_now = instance_spy(Hash)
          controller = spy(:controller, flash: OpenStruct.new(now: flash_now))
          view = build(
            :view,
            message: {
              text: "An alert",
              success: false
            }
          )

          Template.new.call(
            handler: controller,
            view: view
          )

          expect(flash_now).to have_received(:[]=).with(
            :alert,
            "An alert"
          )
        end
      end
    end
  end
end
