# frozen_string_literal: true

module Dry
  module Rails
    # @api private
    class Feature
      # @api private
      attr_reader :name

      # @api private
      def self.[](name)
        klass = Features.const_get(name.to_s.classify)
        klass.new(name)
      end

      # @api private
      def initialize(name)
        @name = name
      end

      # @api private
      def enable!(railtie)
        raise NotImplementedError
      end
    end
  end
end
