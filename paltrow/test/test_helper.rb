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

  def build name, attributes = {}
    if name == :page
      build_page attributes
    else
      build_view attributes
    end
  end

  def build_page attributes
    default_attributes = {
      resource: "tasks",
      action: "edit",
      resource_ids: {
        id: "task-1234",
        project_id: "project-1234"
      },
      query: {
        completed: false
      }
    }
    Paltrow::Page.new(default_attributes.merge(attributes))
  end

  def build_view attributes
    default_attributes = {
      resource: "tasks",
      action: "edit",
      locals: {
        name: "Do the laundry",
        completed: false
      }
    }
    Paltrow::View.new(default_attributes.merge(attributes))
  end
end
