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
        # TODO: this could be moved to dry-system and use a kwarg ie
        #       `load_paths: (true|false)` because sometimes you want
        #       them to be auto-set and sometimes you don't
        #
        # @api public
        def auto_register!(*paths, &block)
          load_paths!(*paths)
          paths.each { |path| super(path, &block) }
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

        if Rails::VERSION.start_with?("5")
          # @api private
          def require_path(path)
            require_dependency(path)
          end
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
