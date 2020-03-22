# frozen_string_literal: true

require "dry/system/loader"

module Dry
  module Rails
    # Customized Container class for Rails application
    #
    # @api public
    module Loaders
      class Namespaced < Dry::System::Loader
        def path
          "#{namespace_path}/#{super}"
        end

        def namespace_path
          Dry::Rails::Railtie.instance.name
        end
      end
    end
  end
end
