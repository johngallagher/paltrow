module Paltrow
  module Rendering
    module Rails
      class Template
        def call handler:, page:
          handler.flash.now[:notice] = page.notice unless page.notice.empty?
          handler.flash.now[:alert] = page.alert unless page.alert.empty?
          handler.render(
            template: "#{page.resource}/#{page.action}",
            locals: page.locals
          )
        end
      end
    end
  end
end
