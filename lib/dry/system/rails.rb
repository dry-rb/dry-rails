# frozen_string_literal: true

require 'rails/railtie'
require 'dry/system/rails/container'

module Dry
  module System
    module Rails
      def self.container(&block)
        @container_block = block
        self
      end

      def self.container_block
        defined?(@container_block) && @container_block
      end

      def self.create_container(options = {})
        container = Class.new(Container).configure { |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.update(options)
        }

        container.load_paths!('lib', 'app', 'app/models')

        container.class_eval(&@container_block) if container_block

        container
      end

      class Railtie < ::Rails::Railtie
        config.to_prepare do
          Railtie.finalize!
        end

        def finalize!
          container = System::Rails.create_container(name: name)

          set_or_reload(:Container, container)

          container.refresh_boot_files if reloading?

          container.finalize!(freeze: freeze?)

          set_or_reload(:Import, container.injector)
        end

        def freeze?
          !::Rails.env.test?
        end

        def reloading?
          app_namespace.const_defined?(:Container)
        end

        def name
          app_namespace.name.underscore.to_sym
        end

        # TODO: we had to rename namespace=>app_namespace because
        #       Rake::DSL's Kernel#namespace *sometimes* breaks things.
        #       Currently we are missing specs verifying that rake tasks work
        #       correctly and those must be added!
        def app_namespace
          @app_namespace ||= begin
            top_level_namespace = ::Rails.application.class.to_s.split('::').first
            Object.const_get(top_level_namespace)
          end
        end

        def set_or_reload(const_name, const)
          if app_namespace.const_defined?(const_name)
            app_namespace.__send__(:remove_const, const_name)
          end

          app_namespace.const_set(const_name, const)
        end
      end
    end
  end
end
