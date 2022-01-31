# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
unless defined? RAILS_VERSION
  RAILS_VERSION = ENV["RAILS_VERSION"] || "6.x"
end

# Maintain your gem's version:
require "super_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "super_engine"
  spec.version     = SuperEngine::VERSION
  spec.authors     = ["Krzysztof Zalewski"]
  spec.email       = ["zlw.zalewski@gmail.com"]
  spec.homepage    = ""
  spec.summary     = ""
  spec.description = ""
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "actionpack", "~> 6.0.2", ">= 6.0.2.1"
  spec.add_dependency "dry-rails"
end
