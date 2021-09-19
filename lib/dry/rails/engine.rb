# frozen_string_literal: true

module Dry
  module Rails
    module Engine
      # Set container block that will be evaluated in the context of the container
      #
      # @param name [Symbol]
      # @return [self]
      #
      # @api public
      def self.container(name, &block)
        _container_blocks[name] << block
        self
      end

      # Create a new container class
      #
      # This is used during booting and reloading
      #
      # @param name [Symbol]
      # @param options [Hash] Container configuration settings
      #
      # @return [Class]
      #
      # @api private
      def self.create_container(options = {})
        Class.new(Container) { config.update(options) }
      end

      # @api private
      def self.evaluate_initializer(name, container)
        _container_blocks[name].each do |block|
          container.class_eval(&block)
        end
      end

      # @api private
      def self._container_blocks
        @_container_blocks ||= Hash.new { |h, k| h[k] = [] }
      end
    end
  end
end
