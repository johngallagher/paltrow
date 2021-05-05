module Paltrow
  module Navigating
    module Rails
      class RedirectTest < Minitest::Test
        def test__given_params__then_redirects_to_page_with_params
          handler = spy(:handler)
          page = Page.new(
            controller: "tasks",
            action: "edit",
            resource_ids: {
              id: "task-1234",
              project_id: "project-1234"
            },
            query: {
              completed: false
            }
          )

          Redirect.new.call(
            handler: handler,
            page: page
          )

          expect(handler).to have_received(:redirect_to).with(
            controller: "tasks",
            action: "edit",
            id: "task-1234",
            project_id: "project-1234",
            completed: false,
            _recall: {}
          )
        end

        def test__given_page_has_message__then_sets_flash_notice
          flash = instance_spy(Hash)
          handler = spy(:handler, flash: flash)
          page = build(:page, message: {text: "A notice", success: true})

          Redirect.new.call(
            handler: handler,
            page: page
          )

          expect(flash).to have_received(:[]=).with(:notice, "A notice")
        end

        def test__given_page_has_failure_message__then_sets_flash_alert
          flash = instance_spy(Hash)
          handler = spy(:handler, flash: flash)
          page = build(:page, message: {text: "An alert", success: false})

          Redirect.new.call(
            handler: handler,
            page: page
          )

          expect(flash).to have_received(:[]=).with(:alert, "An alert")
        end

        def build(name, attributes = {})
          default_attributes = {
            controller: "tasks",
            action: "edit",
            resource_ids: {
              id: "task-1234",
              project_id: "project-1234"
            },
            query: {
              completed: false
            }
          }
          Page.new(default_attributes.merge(attributes))
        end
      end
    end
  end
end
