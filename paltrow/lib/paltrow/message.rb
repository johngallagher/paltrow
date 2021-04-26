module Paltrow
  class Message < Dry::Struct
    attribute :text?, Dry.Types::String.optional.default("".freeze)
    attribute :success, Dry.Types::Bool.optional.default(true)

    def success?
      success
    end

    def failure?
      !success?
    end

    def notice
      success? ? text : ""
    end

    def alert
      failure? ? text : ""
    end
  end
end
