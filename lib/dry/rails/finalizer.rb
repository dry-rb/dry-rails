# frozen_string_literal: true

module Dry
  module Rails
    class Finalizer
      def self.app_namespace_to_name(app_namespace)
        app_namespace.name.underscore.to_sym
      end

      # rubocop:disable Metrics/ParameterLists
      def initialize(
        railtie:,
        app_namespace:,
        root_path:,
        name: Dry::Rails.config.main_app_name,
        container_const_name: Dry::Rails::Container.container_constant,
        default_inflector: ActiveSupport::Inflector
      )
        @railtie = railtie
        @app_namespace = app_namespace
        @root_path = root_path
        @name = name
        @container_const_name = container_const_name
        @default_inflector = default_inflector
      end
      # rubocop:enable Metrics/ParameterLists

      attr_reader :railtie,
                  :root_path,
                  :container_const_name

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
      attr_reader :app_namespace

      # Code-reloading-aware finalization process
      #
      # This sets up `Container` and `Deps` constants, reloads them if this is in reloading mode,
      # and registers default components like the railtie itself or the inflector
      #
      # @api public
      #
      # rubocop:disable Metrics/AbcSize
      def finalize!
        stop_features if reloading?

        container = Dry::Rails::Engine.create_container(
          root: root_path,
          inflector: default_inflector,
          system_dir: root_path.join("config/system"),
          bootable_dirs: [root_path.join("config/system/boot")]
        )

        # Enable :env plugin by default because it is a very common requirement
        container.use :env, inferrer: -> { ::Rails.env }

        container.register(:railtie, railtie)
        container.register(:inflector, default_inflector)

        # Remove previously defined constants, if any, so we don't end up with
        # unsused constants in app's namespace when a name change happens.
        remove_constant(container.auto_inject_constant)
        remove_constant(container.container_constant)

        Dry::Rails::Engine.evaluate_initializer(name, container)

        @container_const_name = container.container_constant

        set_or_reload(container.container_constant, container)
        set_or_reload(container.auto_inject_constant, container.injector)

        container.features.each do |feature|
          container.boot(feature, from: :rails)
        end

        container.refresh_boot_files if reloading?

        container.finalize!(freeze: !::Rails.env.test?)
      end
      # rubocop:enable Metrics/AbcSize

      # Stops all configured features (bootable components)
      #
      # This is *crucial* when reloading code in development mode. Every bootable component
      # should be able to clear the runtime from any constants that it created in its `stop`
      # lifecycle step
      #
      # @api public
      def stop_features
        container.features.each do |feature|
          container.stop(feature) if container.booted?(feature)
        end
      end

      # Exposes the container constant
      #
      # @return [Dry::Rails::Container]
      #
      # @api public
      def container
        app_namespace.const_get(container_const_name, false)
      end

      # Return true if we're in code-reloading mode
      #
      # @api private
      def reloading?
        app_namespace.const_defined?(container_const_name, false)
      end

      # Return the default system name
      #
      # In the dry-system world containers are explicitly named using symbols, so that you can
      # refer to them easily when ie importing one container into another
      #
      # @return [Symbol]
      #
      # @api private
      attr_reader :name

      # Sets or reloads a constant within the application namespace
      #
      # @api private
      attr_reader :default_inflector

      # @api private
      def set_or_reload(const_name, const)
        remove_constant(const_name)
        app_namespace.const_set(const_name, const)
      end

      # @api private
      def remove_constant(const_name)
        if app_namespace.const_defined?(const_name, false)
          app_namespace.__send__(:remove_const, const_name)
        end
      end
    end

    module Engine
      class Finalizer
        # rubocop:disable Metrics/ParameterLists
        def self.new(
          railtie:,
          app_namespace:,
          root_path:,
          name: nil,
          container_const_name: Dry::Rails::Container.container_constant,
          default_inflector: ActiveSupport::Inflector
        )
          Dry::Rails::Finalizer.new(
            railtie: railtie,
            app_namespace: app_namespace,
            root_path: root_path,
            name: name || ::Dry::Rails::Finalizer.app_namespace_to_name(app_namespace),
            container_const_name: container_const_name,
            default_inflector: default_inflector
          )
        end
        # rubocop:enable Metrics/ParameterLists
      end
    end
  end
end
