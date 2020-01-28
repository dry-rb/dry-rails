# frozen_string_literal: true
# this file is managed by dry-rb/devtools project

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'dry-rails'
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.license       = 'MIT'
  spec.version       = Dry::Rails::VERSION.dup

  spec.summary       = "The official dry-rb railtie for Ruby on Rails"
  spec.description   = "The railtie provides a smooth integration with dry-system, integrates dry-rb components with the controllers and more"
  spec.homepage      = 'https://dry-rb.org/gems/dry-rails'
  spec.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "dry-rails.gemspec", "lib/**/*"]
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['changelog_uri']     = 'https://github.com/dry-rb/dry-rails/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri']   = 'https://github.com/dry-rb/dry-rails'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/dry-rb/dry-rails/issues'

  spec.required_ruby_version = ">= 2.4.0"

  # to update dependencies edit project.yml
  spec.add_runtime_dependency "dry-matcher", "~> 0.8"
  spec.add_runtime_dependency "dry-monads", "~> 1.3"
  spec.add_runtime_dependency "dry-system", "~> 0.14"
  spec.add_runtime_dependency "dry-types", "~> 1.2"
  spec.add_runtime_dependency "dry-validation", "~> 1.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
