# frozen_string_literal: true

require "rails/version"

require "dry/system/container"
require "dry/system/components"

require "dry/rails/auto_registrars/app"

module Dry
  module Rails
    # Customized Container class for Rails applications
    #
    # @api public
    class Container < System::Container
      # @!group Configuration

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
      setting :features,
              default: %i[application_contract safe_params controller_helpers],
              reader: true

      # @overload config.auto_inject_constant=(auto_inject_constant)
      #   Set a custom import constant name
      #
      #   @param auto_inject_constant [String]
      #
      #   @api public
      # @!scope class
      setting :auto_inject_constant,
              default: "Deps",
              reader: true

      # @overload config.container_constant=(container_constant)
      #   Set a custom container constant
      #
      #   @param container_constant [String]
      #
      #   @api public
      # @!scope class
      setting :container_constant,
              default: "Container",
              reader: true

      # @!endgroup

      # The railtie has a rails-specific auto-registrar which is app-dir aware
      config.auto_registrar = Rails::AutoRegistrars::App

      class << self
        # Return if a given component was booted
        #
        # @return [Boolean]
        #
        # @api private
        #
        # TODO: this should be moved to dry-system
        def booted?(name)
          booter.booted.map(&:name).include?(name)
        end

        # TODO: confirm that this is really needed
        if ::Rails.version.start_with?("5")
          # @api private
          def require_path(path)
            require_dependency(path)
          end
        end

        # This is called when reloading in dev mode
        #
        # @return [self]
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
