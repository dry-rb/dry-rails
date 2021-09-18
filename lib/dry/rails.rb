# frozen_string_literal: true

require "dry/rails/railtie"
require "dry/rails/engine"

module Dry
  # Initializer interface
  #
  # @example set up a container with auto-registration paths
  #   # config/initializer/system.rb
  #
  #   Dry::Rails.container do
  #     auto_register!("lib", "app/operations")
  #   end
  #
  # @see Dry::Rails::Container.auto_register!
  #
  # @api public
  module Rails
    extend Dry::Configurable
    setting :main_app_name
    setting :main_app_enabled, default: true

    # Set container block that will be evaluated in the context of the container
    #
    # @return [self]
    #
    # @api public
    def self.container(&block)
      Engine.container(config.main_app_name, &block)
    end

    # Create a new container class
    #
    # This is used during booting and reloading
    #
    # @param options [Hash] Container configuration settings
    #
    # @return [Class]
    #
    # @api private
    def self.create_container(options = {})
      Engine.create_container(options)
    end

    # @api private
    def self.evaluate_initializer(container)
      Engine.evaluate_initializer(config.main_app_name, container)
    end
  end
end
