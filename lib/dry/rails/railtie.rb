# frozen_string_literal: true

require 'rails/railtie'

module Dry
  module Rails
    # System railtie is responsible for setting up a container and handling reloading in dev mode
    #
    # @api private
    class Railtie < ::Rails::Railtie
      config.to_prepare do
        Railtie.finalize!
      end

      # @api private
      def finalize!
        container = Dry::Rails.create_container(name: name)

        set_or_reload(:Container, container)
        set_or_reload(:Import, container.injector)

        container.refresh_boot_files if reloading?

        container.finalize! unless ::Rails.env.test?
      end

      # @api private
      def reloading?
        app_namespace.const_defined?(:Container)
      end

      # @api private
      def name
        app_namespace.name.underscore.to_sym
      end

      # TODO: we had to rename namespace=>app_namespace because
      #       Rake::DSL's Kernel#namespace *sometimes* breaks things.
      #       Currently we are missing specs verifying that rake tasks work
      #       correctly and those must be added!
      #
      # @api private
      def app_namespace
        @app_namespace ||= begin
          top_level_namespace = ::Rails.application.class.to_s.split("::").first
          Object.const_get(top_level_namespace)
        end
      end

      # @api private
      def set_or_reload(const_name, const)
        if app_namespace.const_defined?(const_name)
          app_namespace.__send__(:remove_const, const_name)
        end

        app_namespace.const_set(const_name, const)
      end
    end
  end
end
