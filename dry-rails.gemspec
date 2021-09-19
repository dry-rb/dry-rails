# frozen_string_literal: true

# this file is synced from dry-rb/template-gem project

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-rails"
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.license       = "MIT"
  spec.version       = Dry::Rails::VERSION.dup

  spec.summary       = "The official dry-rb railtie for Ruby on Rails"
  spec.description   = "dry-rails provides the official integration of dry-rb gems with Ruby on Rails framework."
  spec.homepage      = "https://dry-rb.org/gems/dry-rails"
  spec.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "dry-rails.gemspec", "lib/**/*"]
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["changelog_uri"]     = "https://github.com/dry-rb/dry-rails/blob/master/CHANGELOG.md"
  spec.metadata["source_code_uri"]   = "https://github.com/dry-rb/dry-rails"
  spec.metadata["bug_tracker_uri"]   = "https://github.com/dry-rb/dry-rails/issues"

  spec.required_ruby_version = ">= 2.6.0"

  # to update dependencies edit project.yml
  spec.add_runtime_dependency "dry-schema", "~> 1.7"
  spec.add_runtime_dependency "dry-system", "~> 0.21"
  spec.add_runtime_dependency "dry-validation", "~> 1.5"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  # our super engine used in specs
  spec.add_development_dependency "super_engine"
end
