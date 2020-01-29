# frozen_string_literal: true

require 'dry/system/auto_registrar'

require 'dry/rails/loaders'

module Dry
  module Rails
    module AutoRegistrarStrategies
      class Namespaced < Dry::System::AutoRegistrar
        def component(path, **options)
          super(path, **options, loader: Loaders::Namespaced)
        end
      end
    end
  end
end
