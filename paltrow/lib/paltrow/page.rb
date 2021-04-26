module Paltrow
  class Page < Dry::Struct
    attribute :controller, Dry.Types::String
    attribute :action, Dry.Types::String.enum("new", "edit", "show", "index")
    attribute :query?, Dry.Types::Hash.optional.default({}.freeze)
    attribute :resource_ids?, Dry.Types::Hash.optional.default({}.freeze)
    attribute :message?, Message.default { Message.new }

    def to_params
      {controller: controller, action: action}
        .merge(query)
        .merge(resource_ids)
    end
  end
end
