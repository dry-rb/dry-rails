# frozen_string_literal: true

require 'rails/railtie'
require 'dry/system/rails/container'

module Dry
  module System
    module Rails
      extend Dry::Configurable

      setting :auto_register, []

      def self.configure
        super

        container = create_container(config)

        Railtie.configure do
          config.container = container
        end
      end

      def self.create_container(defaults)
        auto_register = defaults.auto_register

        container = Class.new(Container).configure { |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.auto_register = auto_register
        }

        container.load_paths!('lib', 'app', 'app/models')
      end

      class Railtie < ::Rails::Railtie
        initializer 'dry.system.create_container' do
          System::Rails.configure
        end

        config.to_prepare do |*_args|
          Railtie.finalize!
        end

        def finalize!
          reload(:Container)

          reload(:Import)

          container.config.name = name

          container.finalize!(freeze: !::Rails.env.test?)
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

        def container
          Railtie.config.container
        end

        def import
          container.injector
        end

        def reload(const_name)
          app_namespace.__send__(:remove_const, const_name) if app_namespace.const_defined?(const_name)
          app_namespace.const_set(const_name, __send__(const_name.to_s.underscore))
        end
      end
    end
  end
end
