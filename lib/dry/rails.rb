# frozen_string_literal: true

require "dry/rails/railtie"
require "dry/rails/engine"
require "dry/rails/finalizer"
require "dry/rails/container"
require "dry/rails/components"

module Dry
  # Initializer interface
  #
  # @example set up a container with auto-registration paths
  #   # config/initializer/system.rb
  #
  #   Dry::Rails.container do
  #     config.component_dirs.add "lib" do |dir|
  #       dir.namespaces.add "my_super_cool_app", key: nil
  #     end
  #
  #     config.component_dirs.add "app/operations"
  #   end
  #
  # @api public
  module Rails
    extend Configurable
    # Set to true to turn off dry-system for main application
    # Meant to be used in setup where dry-system is only used within Rails::Engine(s)
    #
    # @api public
    setting :main_app_disabled, default: false

    # This is being injected by main app Railtie
    # @api private
    setting :main_app_name

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
