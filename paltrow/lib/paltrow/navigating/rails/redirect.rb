module Paltrow
  module Navigating
    module Rails
      class Redirect
        def call controller:, page:
          controller.flash[:notice] = page.notice unless page.notice.empty?
          controller.flash[:alert] = page.alert unless page.alert.empty?
          controller.redirect_to(page.to_params.merge(_recall: {}))
        end
      end
    end
  end
end
