module Paltrow
  module Navigating
    module Rails
      class Redirect
        def call handler:, page:
          handler.flash[:notice] = page.notice unless page.notice.empty?
          handler.flash[:alert] = page.alert unless page.alert.empty?
          handler.redirect_to(page.to_params.merge(_recall: {}))
        end
      end
    end
  end
end
