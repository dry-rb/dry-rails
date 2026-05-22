# frozen_string_literal: true

require "dry/schema"

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

          klass.class_eval do
            before_action(:set_safe_params, prepend: true)
          end
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
          return @schemas if defined? @schemas

          @schemas = if self.class.superclass.include?(Dry::Rails::Features::SafeParams)
                       self.class.schemas.merge(self.class.superclass.schemas)
                     else
                       self.class.schemas
                     end
        end

        private

        # @api private
        def set_safe_params
          schema = schemas[action_name.to_sym]

          return unless schema

          @safe_params = schema.(request.params)
        end
      end
    end
  end
end
