# frozen_string_literal: true

require "rails/railtie"

module Dry
  module Rails
    # The railtie is responsible for setting up a container and handling reloading in dev mode
    #
    # @api public
    class Railtie < ::Rails::Railtie
      # This is needed because `finalize!` can reload code and this hook is called every-time
      # in development env upon a request (in production it's called just once during booting)
      config.to_prepare do
        Railtie.finalize! unless Dry::Rails.config.main_app_disabled
      end

      initializer "dry-rails.main-app-container" do
        Dry::Rails.config.main_app_name = Dry::Rails::Finalizer.app_namespace_to_name(app_namespace)
      end

      # Infer the default application namespace
      #
      # TODO: we had to rename namespace=>app_namespace because
      #       Rake::DSL's Kernel#namespace *sometimes* breaks things.
      #       Currently we are missing specs verifying that rake tasks work
      #       correctly and those must be added!
      #
      # @return [Module]
      #
      # @api public
      def app_namespace
        @app_namespace ||= begin
          top_level_namespace = ::Rails.application.class.to_s.split("::").first
          Object.const_get(top_level_namespace)
        end
      end

      # Code-reloading-aware finalization process
      #
      # This sets up `Container` and `Deps` constants, reloads them if this is in reloading mode,
      # and registers default components like the railtie itself or the inflector
      #
      # @api public
      delegate :finalize!, to: :finalizer
      alias_method :reload, :finalize!

      # Stops all configured features (bootable components)
      #
      # This is *crucial* when reloading code in development mode. Every bootable component
      # should be able to clear the runtime from any constants that it created in its `stop`
      # lifecycle step
      #
      # @api public
      delegate :stop_features, to: :finalizer

      # Exposes the container constant
      #
      # @return [Dry::Rails::Container]
      #
      # @api public
      delegate :container, to: :finalizer

      # @api private
      delegate :set_or_reload, to: :finalizer

      # @api private
      delegate :remove_constant, to: :finalizer

      private

      def finalizer
        @finalizer ||= Finalizer.new(
          railtie: self,
          app_namespace: app_namespace,
          root_path: ::Rails.root
        )
      end
    end
  end
end
