# frozen_string_literal: true

require "dry/system/auto_registrar"

module Dry
  module Rails
    module AutoRegistrars
      # This is the default auto-registrar configured in the Container
      #
      # @api private
      class App < System::AutoRegistrar
        # Resolve a path relative to the system root
        #
        # This works just like in `dry-system` except that it's app-dir aware. This means it will
        # turn `app/operations/foo/bar` to `foo/bar` because app dirs are treated as root dirs.
        #
        # In a typical dry-system setup `app` would be the root and everything inside this path
        # would indicate the constant hierachy, so `app/operations/foo/bar` => `Operations/Foo/Bar`
        # but *this is not the Rails convention* so we need this special auto-registrar.
        #
        # @api private
        def relative_path(dir, file_path)
          path = super
          return path unless dir.start_with?("app")

          path.split("/")[1..].join("/")
        end
      end
    end
  end
end
