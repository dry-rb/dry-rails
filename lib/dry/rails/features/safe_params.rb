# frozen_string_literal: true

require "dry/schema/params"

module Dry
  module Rails
    module Features
      # SafeParams controller feature
      #
      # @api public
      module SafeParams
        # @api private
        def self.included(klass)
          super
          klass.extend(ClassMethods)
        end

        # ApplicationController methods
        #
        # @api public
        module ClassMethods
          # Define a schema for controller action(s)
          #
          # @param actions [Array<Symbol>]
          #
          # @return [self]
          #
          # @api public
          def schema(*actions, &block)
            schema = Dry::Schema.Params(&block)

            actions.each do |name|
              schemas[name] = schema
            end

            before_action(:set_safe_params)

            self
          end

          # Return registered schemas
          #
          # @api private
          def schemas
            @schemas ||= {}
          end
        end

        # Return schema result
        #
        # @return [Dry::Schema::Result]
        #
        # @api public
        def safe_params
          @safe_params
        end

        # Return registered action schemas
        #
        # @return [Hash<Symbol => Dry::Schema::Params]
        #
        # @api public
        def schemas
          self.class.schemas
        end

        private

        # @api private
        def set_safe_params
          @safe_params = schemas[action_name.to_sym].(request.params)
        end
      end
    end
  end
end
