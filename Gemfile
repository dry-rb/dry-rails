# frozen_string_literal: true

source "https://rubygems.org"

gemspec

eval_gemfile "Gemfile.devtools"

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.4.0")
  gem "base64"
  gem "benchmark"
  gem "drb"
  gem "mutex_m"
end

RAILS_VERSION = (ENV["RAILS_VERSION"] || "6.0").sub("x", "0")

%w[railties actionview actionpack].each do |name|
  gem name, "~> #{RAILS_VERSION}"
end

group :test do
  gem "rspec-rails"
end

group :tools do
  gem "redcarpet"
end
