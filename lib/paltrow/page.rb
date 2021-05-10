module Paltrow
  class Page < Dry::Struct
    attribute :resource, Dry.Types::Strict::String
    attribute :action, Dry.Types::Strict::String.enum("new", "edit", "show", "index")
    attribute :message, Dry.Types::Strict::String.default("".freeze)
    attribute :success, Dry.Types::Bool.default(true)

    attribute :locals, Dry.Types::Strict::Hash.default({}.freeze)
    attribute :query, Dry.Types::Strict::Hash.default({}.freeze)
    attribute :resource_ids, Dry.Types::Strict::Hash.default({}.freeze)

    PageWithURL = Struct.new(:to_params, keyword_init: true) do
      def notice
        ""
      end

      def alert
        ""
      end
    end

    def self.with_url(url)
      PageWithURL.new(to_params: url)
    end

    def to_params
      {resource: resource, action: action}
        .merge(query)
        .merge(resource_ids)
    end

    def success?
      success
    end

    def failure?
      !success?
    end

    def notice
      success? ? message : ""
    end

    def alert
      failure? ? message : ""
    end

    def with_notice a_notice
      new(message: a_notice, success: true)
    end

    def with_alert an_alert
      new(message: an_alert, success: false)
    end

    def to_monad
      success? ? Dry::Monads::Success(self) : Dry::Monads::Failure(self)
    end
  end
end
