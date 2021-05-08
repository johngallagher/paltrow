module Paltrow
  module Navigating
    module Rails
      class Redirect
        def call handler:, page:
          handler.flash[:notice] = page.notice unless page.notice.empty?
          handler.flash[:alert] = page.alert unless page.alert.empty?

          page
            .to_params
            .merge(_recall: {})
            .transform_keys { |key| key.to_s.gsub("resource", "controller").to_sym }
            .then { |params| handler.redirect_to(params) }
        end
      end
    end
  end
end
