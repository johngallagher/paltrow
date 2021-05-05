module Paltrow
  module Navigating
    module Rails
      class Redirect
        def call controller:, page:
          controller.redirect_to(page.to_params.merge(_recall: {}))
        end
      end
    end
  end
end
