# frozen_string_literal: true

require "dry/system/container"
require "dry/system/components"

require "dry/rails/auto_registrars/app"

module Dry
  module Rails
    # Customized Container class for Rails applications
    #
    # @api public
    class Container < System::Container
      # @overload config.features=(features)
      #   Set an array of features that should be enabled by default
      #
      #   Available values are:
      #   - application_contract
      #   - safe_params
      #   - controller_helpers
      #
      #   @param features [Array<Symbol>]
      #
      #   @api public
      # @!scope class
      setting :features, %i[application_contract safe_params controller_helpers], reader: true

      # @overload config.auto_register_paths=(paths)
      #   Set an array of path/block pairs for auto-registration
      #
      #   This is a low-level setting that typically should not be set explicitly,
      #   use `auto_register!` instead.
      #
      #   @param paths [Array<Array>]
      #
      #   @api public
      # @!scope class
      setting :auto_register_paths, [].freeze, reader: true

      # @!endgroup

      # The railtie has a rails-specific auto-registrar which is app-dir aware
      config.auto_registrar = Rails::AutoRegistrars::App

      class << self
        # Set up auto-registration paths and optional a configuration block
        #
        # @example set up a single path
        #   Dry::Rails.container do
        #     auto_register!("app/operations")
        #   end
        #
        # @example set up a single path with a configuration block
        #   Dry::Rails.container do
        #     auto_register!("app/operations") do |config|
        #       config.exclude do |component|
        #         component.path.start_with?("concerns")
        #       end
        #     end
        #   end
        #
        # @example set up multiple paths
        #   Dry::Rails.container do
        #     auto_register!("lib", "app/operations") do |config|
        #       config.exclude do |component|
        #         component.path.start_with?("concerns")
        #       end
        #     end
        #   end
        #
        # @example set up multiple paths with a configuration block
        #   Dry::Rails.container do
        #     # in this case the config block will be applied to all paths
        #     auto_register!("lib", "app/operations") do |config|
        #       config.exclude do |component|
        #         component.path.start_with?("concerns")
        #       end
        #     end
        #   end
        #
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

        # Finalize the container
        #
        # This is called automatically via the railtie, so typically you won't be using this method
        # directly
        #
        # @return [Container]
        #
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
        # TODO: this should be moved to dry-system
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
