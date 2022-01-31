# frozen_string_literal: true

require "dry-rails"

module SuperEngine
  class Engine < ::Rails::Engine
    isolate_namespace SuperEngine

    initializer "super_engine.dry-container" do |_app|
      Dry::Rails::Engine.container(:super_engine) do
        config.component_dirs.add "app/operations"
      end
    end

    # This is needed because `finalize!` can reload code and this hook is called every-time
    # in development env upon a request (in production it's called just once during booting)
    config.to_prepare do
      Engine.finalize!
    end

    # Code-reloading-aware finalization process
    #
    # This sets up `Container` and `Deps` constants, reloads them if this is in reloading mode,
    # and registers default components like the railtie itself or the inflector
    #
    # @api public
    #
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
      @finalizer ||= Dry::Rails::Engine::Finalizer.new(
        railtie: self,
        app_namespace: SuperEngine,
        root_path: ::Rails.root.join("engines/super_engine")
      )
    end
  end
end
