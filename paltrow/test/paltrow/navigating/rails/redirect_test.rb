module Paltrow
  module Navigating
    module Rails
      class RedirectTest < Minitest::Test
        def test_redirects_to_page_with_params_and_blank_recall
          controller = spy(:controller)
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
            controller: controller,
            page: page
          )

          expect(controller).to have_received(:redirect_to).with(
            controller: "tasks",
            action: "edit",
            id: "task-1234",
            project_id: "project-1234",
            completed: false,
            _recall: {}
          )
        end
      end
    end
  end
end
