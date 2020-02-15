# frozen_string_literal: true

require 'dry/validation/contract'

module Dry
  module Rails
    module Core
      class ApplicationContract < Dry::Validation::Contract
        # @api private
        def self.finalize!(railtie)
          load_paths = Dir[railtie.container.root.join('config/locales/*.yml')]

          config.messages.top_namespace = :contracts
          config.messages.backend = :i18n
          config.messages.load_paths += load_paths

          self
        end
      end
    end
  end
end
