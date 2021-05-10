module Paltrow
  module Navigating
    module Rails
      class Redirect
        def call handler:, page:
          handler.flash[:notice] = page.notice unless page.notice.empty?
          handler.flash[:alert] = page.alert unless page.alert.empty?

          page
            .to_params
            .then(&adapt_params_to_rails)
            .then { |params| handler.redirect_to(params) }
        end

        def adapt_params_to_rails
          lambda do |params|
            if params.is_a?(Hash)
              params
                .merge(_recall: {})
                .transform_keys { |key| key.to_s.gsub("resource", "controller").to_sym }
            else
              params
            end
          end
        end
      end
    end
  end
end
