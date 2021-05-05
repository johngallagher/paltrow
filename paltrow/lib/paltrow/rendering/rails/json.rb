module Paltrow
  module Rendering
    module Rails
      class JSON
        def call handler:, view:
          view
            .to_monad
            .fmap { |view| handler.render(json: view.locals) }
            .or { |error| handler.render(json: {error: error.message}, status: :unprocessable_entity) }
        end
      end
    end
  end
end
