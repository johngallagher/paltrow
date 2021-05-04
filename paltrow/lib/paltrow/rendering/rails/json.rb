module Paltrow
  module Rendering
    module Rails
      class JSON
        def call controller:, view:
          view
            .to_monad
            .fmap { |view| controller.render(json: view.locals) }
            .or { |error| controller.render(json: {error: error.message}, status: :unprocessable_entity) }
        end
      end
    end
  end
end
