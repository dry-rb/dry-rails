# frozen_string_literal: true

require "dry/system/container"
require "dry/system/components"

require "dry/rails/errors"
require "dry/rails/auto_registrars/app"

module Dry
  module Rails
    # Customized Container class for Rails application
    #
    # @api public
    class Container < System::Container
      setting :features, %i[application_contract safe_params], reader: true

      config.auto_registrar = Rails::AutoRegistrars::App

      class << self
        # @api public
        def auto_register!(*args, &block)
          load_paths!(*args)
          super
          self
        end

        # Return if a given component was booted
        #
        # @return [Boolean]
        #
        # @api private
        def booted?(name)
          booter.booted.map(&:identifier).include?(name)
        end

        # @api private
        def require_path(path)
          ::Kernel.require(path)
        end

        # This is called when reloading in dev mode
        #
        # @api private
        def refresh_boot_files
          booter.boot_files.each do |boot_file|
            load(boot_file)
          end
          self
        end
      end
    end
  end
end
