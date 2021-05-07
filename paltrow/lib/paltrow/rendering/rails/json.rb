module Paltrow
  module Rendering
    module Rails
      class JSON
        def call handler:, page:
          page
            .to_monad
            .fmap { |page| handler.render(json: page.locals) }
            .or { |page| handler.render(json: {error: page.message}, status: :unprocessable_entity) }
        end
      end
    end
  end
end
