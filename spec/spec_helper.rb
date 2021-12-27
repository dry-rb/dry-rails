# frozen_string_literal: true

require_relative "support/coverage"

begin
  require "byebug"
rescue LoadError; end
require "dry-rails"

SPEC_ROOT = Pathname(__dir__)

Dir[SPEC_ROOT.join("shared/**/*.rb")].sort.each(&method(:require))
Dir[SPEC_ROOT.join("support/**/*.rb")].sort.each(&method(:require))

ENV["RAILS_ENV"] ||= "test"

RAILS_VERSION = ENV["RAILS_VERSION"] || "6.x"
DUMMY_DIR     = ENV["TEST_DUMMY"] || "with-engine"
WITH_ENGINE   = DUMMY_DIR == "with-engine"
require SPEC_ROOT.join("dummies/#{DUMMY_DIR}/dummy-#{RAILS_VERSION}/dummy/config/environment").to_s

require "rspec/rails"

RSpec.configure do |config|
  if WITH_ENGINE
    config.filter_run_excluding main_app: true
  else
    config.filter_run_excluding engine:   true
  end

  config.disable_monkey_patching!

  config.before do |example|
    Rails.application.reloader.reload! unless example.metadata[:no_reload]
  end

  config.around(production: true) do |example|
    prev_env = Rails.env
    Rails.env = "production"
    example.run
  ensure
    Rails.env = prev_env
  end
end
