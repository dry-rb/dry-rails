# frozen_string_literal: true

# This file is synced from hanakai-rb/repo-sync. To update it, edit repo-sync.yml.

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-rails"
  spec.authors       = ["Hanakai team"]
  spec.email         = ["info@hanakai.org"]
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
  spec.metadata["changelog_uri"]     = "https://github.com/dry-rb/dry-rails/blob/main/CHANGELOG.md"
  spec.metadata["source_code_uri"]   = "https://github.com/dry-rb/dry-rails"
  spec.metadata["bug_tracker_uri"]   = "https://github.com/dry-rb/dry-rails/issues"
  spec.metadata["funding_uri"]       = "https://github.com/sponsors/hanami"

  spec.required_ruby_version = ">= 3.1"

  spec.add_runtime_dependency "dry-schema", "~> 1.7"
  spec.add_runtime_dependency "dry-system", "~> 1.0", "< 2"
  spec.add_runtime_dependency "dry-validation", "~> 1.5"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

