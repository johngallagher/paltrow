module Paltrow
  module Rendering
    module Rails
      class Template
        def call handler:, view:
          handler.flash.now[:notice] = view.notice unless view.notice.empty?
          handler.flash.now[:alert] = view.alert unless view.alert.empty?
          handler.render(
            template: "#{view.resource}/#{view.action}",
            locals: view.locals
          )
        end
      end
    end
  end
end
