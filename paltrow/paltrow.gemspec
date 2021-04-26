require_relative "lib/paltrow/version"

Gem::Specification.new do |spec|
  spec.name = "paltrow"
  spec.version = Paltrow::VERSION
  spec.authors = ["John Gallagher"]
  spec.email = ["john@synapticmishap.co.uk"]

  spec.summary = "Conciously decouple from your framework"
  spec.description = "Write your web app in plain old Ruby then plug into any web framework"
  spec.homepage = "https://github.com/johngallagher/paltrow"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.6")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/johngallagher/paltrow/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dry-struct", "~> 1.4"
  spec.add_development_dependency "standard", "~> 1.0"
end
