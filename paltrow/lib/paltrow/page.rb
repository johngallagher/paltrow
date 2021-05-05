module Paltrow
  class Page < Dry::Struct
    attribute :resource, Dry.Types::String
    attribute :action, Dry.Types::String.enum("new", "edit", "show", "index")
    attribute :query?, Dry.Types::Hash.optional.default({}.freeze)
    attribute :resource_ids?, Dry.Types::Hash.optional.default({}.freeze)
    attribute :message?, Message.default { Message.new }

    def to_params
      {resource: resource, action: action}
        .merge(query)
        .merge(resource_ids)
    end

    def notice
      message.notice
    end

    def alert
      message.alert
    end

    def with_notice a_notice
      new(message: Message.notice(a_notice))
    end

    def with_alert an_alert
      new(message: Message.alert(an_alert))
    end
  end
end
