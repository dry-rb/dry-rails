# frozen_string_literal: true

require "dry/system/auto_registrar"

module Dry
  module Rails
    module AutoRegistrars
      # @api private
      class App < System::AutoRegistrar
        # @api private
        def relative_path(dir, file_path)
          path = super
          return path unless dir.start_with?("app")

          path.split("/")[1..-1].join("/")
        end
      end
    end
  end
end
