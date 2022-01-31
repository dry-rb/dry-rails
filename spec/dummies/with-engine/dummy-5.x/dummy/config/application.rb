# frozen_string_literal: true

require_relative "boot"

require "rails"
require "action_controller/railtie"

Bundler.setup(*Rails.groups)

module Dummy
  class Application < Rails::Application
    config.root = Pathname(__dir__).join("..").realpath
  end
end
