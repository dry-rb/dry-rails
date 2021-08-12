# frozen_string_literal: true

source "https://rubygems.org"

gemspec

eval_gemfile "Gemfile.devtools"

RAILS_VERSION = (ENV["RAILS_VERSION"] || "6.0").sub("x", "0")

gem "dry-configurable", github: "dry-rb/dry-configurable", branch: "master" if ENV["DRY_CONFIGURABLE_FROM_MASTER"].eql?("true")

%w[railties actionview actionpack].each do |name|
  gem name, "~> #{RAILS_VERSION}"
end

group :test do
  gem "rspec-rails"
end

group :tools do
  gem "byebug", platform: :ruby
  gem "redcarpet"
end
