# frozen_string_literal: true

require "dry/rails/railtie"
require "dry/rails/container"
require "dry/rails/components"

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
    # Set container block that will be evaluated in the context of the container
    #
    # @return [self]
    #
    # @api public
    def self.container(&block)
      _container_blocks << block
      self
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
      Class.new(Container) { config.update(options) }
    end

    # @api private
    def self.evaluate_initializer(container)
      _container_blocks.each do |block|
        container.class_eval(&block)
      end
    end

    # @api private
    def self._container_blocks
      @_container_blocks ||= []
    end
  end
end
