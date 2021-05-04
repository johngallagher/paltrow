require "dry-struct"
require "dry-monads"
require "dry/monads/result"
require "paltrow/version"
require "paltrow/message"
require "paltrow/view"
require "paltrow/page"
require "paltrow/rendering/rails/json"

module Paltrow
  class Error < StandardError; end

  class ViewError < StandardError; end
end
