# frozen_string_literal: true

require 'dry/rails/railtie'
require 'dry/rails/container'
require 'dry/rails/components'

module Dry
  # Initializer interface
  #
  # @example set up a customized container
  #   # config/initializer/system.rb
  #
  #   Dry::Rails.container do
  #     use :monitoring
  #
  #     config.auto_register << 'app/operations'
  #   end
  #
  # @api public
  module Rails
    # Set container block that will be evaluated in the context of the container
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
    # @api private
    def self.create_container(options = {})
      container = Class.new(Container)

      _container_blocks.each do |block|
        container.class_eval(&block)
      end

      default_options = {
        root: ::Rails.root,
        system_dir: ::Rails.root.join('config/system')
      }
      container.config.update(default_options.merge(options))

      container.load_paths!('lib', 'app', 'app/models')

      container
    end

    # @api private
    def self._container_blocks
      @_container_blocks ||= []
    end
  end
end
