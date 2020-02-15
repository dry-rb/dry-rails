# frozen_string_literal: true

require 'dry/rails/feature'
require 'dry/rails/core/application_contract'

module Dry
  module Rails
    module Features
      # @api private
      class ApplicationContract < Feature
        # @api private
        def enable!(railtie)
          railtie.set_or_reload(
            :ApplicationContract, create_class.finalize!(railtie)
          )
        end

        # @api private
        def create_class
          Class.new(Core::ApplicationContract)
        end
      end
    end
  end
end
