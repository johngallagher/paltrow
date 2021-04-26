module Paltrow
  class View < Dry::Struct
    attribute :controller, Dry.Types::String
    attribute :action, Dry.Types::String.enum("new", "edit", "show", "index")
    attribute :locals?, Dry.Types::Hash.optional.default({}.freeze)
    attribute :message?, Message.default { Message.new }

    def notice
      message.notice
    end

    def alert
      message.alert
    end
  end
end
