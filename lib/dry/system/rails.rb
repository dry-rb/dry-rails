# frozen_string_literal: true

require 'dry/system/rails/railtie'
require 'dry/system/rails/container'

module Dry
  module System
    # Initializer interface
    #
    # @example set up a customized container
    #   # config/initializer/system.rb
    #
    #   Dry::System::Rails.container do
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
        @container_block = block
        self
      end

      # Create a new container class
      #
      # This is used during booting and reloading
      #
      # @api private
      def self.create_container(options = {})
        container = Class.new(Container).configure { |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.update(options)
        }

        container.load_paths!('lib', 'app', 'app/models')

        container.class_eval(&@container_block) if container_block

        container
      end

      # @api private
      def self.container_block
        defined?(@container_block) && @container_block
      end
    end
  end
end
