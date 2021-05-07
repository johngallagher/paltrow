require "dry-struct"
require "dry-monads"
require "dry/monads/result"
require "paltrow/version"
require "paltrow/page"
require "paltrow/rendering/rails/json"
require "paltrow/rendering/rails/template"
require "paltrow/rendering/rails/stream"
require "paltrow/navigating/rails/redirect"

module Paltrow
  class Error < StandardError; end

  class ViewError < StandardError; end
end
