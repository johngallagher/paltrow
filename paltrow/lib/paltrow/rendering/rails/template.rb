module Paltrow
  module Rendering
    module Rails
      class Template
        def call handler:, view:
          handler.render(
            template: "#{view.resource}/#{view.action}",
            locals: view.locals
          )
        end
      end
    end
  end
end
