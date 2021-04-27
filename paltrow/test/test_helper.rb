$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "paltrow"

require "minitest/autorun"
require "rspec/mocks/minitest_integration"

class Minitest::Test
  include ::RSpec::Mocks::ExampleMethods

  def before_setup
    ::RSpec::Mocks.setup
    ::RSpec::Mocks.configuration.allow_message_expectations_on_nil = false
    super
  end

  def after_teardown
    super
    ::RSpec::Mocks.verify
  ensure
    ::RSpec::Mocks.teardown
  end
end
