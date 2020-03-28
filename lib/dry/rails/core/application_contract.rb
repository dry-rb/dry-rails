# frozen_string_literal: true

require "dry/validation/contract"

module Dry
  module Rails
    module Core
      # Abstract application contract class used by the `:application_contract` feature
      #
      # This is an abstract class that's pre-configured during booting process to serve as the base
      # class that the ApplicationContract class inherits from.
      #
      # @see https://dry-rb.org/gems/dry-validation/1.5/configuration/
      #
      # @abstract
      #
      # @api public
      class ApplicationContract < Dry::Validation::Contract
        # This is called during the booting process of the `:application_contract` feature
        #
        # @return [self]
        #
        # @api private
        def self.finalize!(railtie)
          load_paths = Dir[railtie.container.root.join("config/locales/*.yml")]

          config.messages.top_namespace = :contracts
          config.messages.backend = :i18n
          config.messages.load_paths += load_paths

          self
        end
      end
    end
  end
end
