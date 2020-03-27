# frozen_string_literal: true

require "dry/system/container"
require "dry/system/components"

require "dry/rails/auto_registrars/app"

module Dry
  module Rails
    # Customized Container class for Rails application
    #
    # @api public
    class Container < System::Container
      setting :features, %i[application_contract safe_params controller_helpers], reader: true

      setting :auto_register_paths, [].freeze, reader: true

      config.auto_registrar = Rails::AutoRegistrars::App

      class << self
        # TODO: this could be moved to dry-system and use a kwarg ie
        #       `load_paths: (true|false)` because sometimes you want
        #       them to be auto-set and sometimes you don't
        #
        # @api public
        def auto_register!(*paths, set_load_paths: true, load_files: false, &block)
          load_paths!(*paths) if set_load_paths

          if load_files
            paths.each { |path| super(path, &block) }
          else
            config.auto_register_paths.concat(paths.product([block]))
          end

          self
        end

        # @api public
        def finalize!(freeze: false, &block)
          features.each do |feature|
            start(feature)
          end

          auto_register_paths.each do |(path, path_block)|
            auto_register!(path, set_load_paths: false, load_files: true, &path_block)
          end

          super
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
