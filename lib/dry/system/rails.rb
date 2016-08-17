require 'dry/system/container'
require 'rails/railtie'

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

        container = Class.new(Dry::System::Container).configure do |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.auto_register = auto_register
        end

        container.load_paths!('lib', 'app', 'app/models')
      end

      class Railtie < ::Rails::Railtie
        config.to_prepare do |*args|
          Railtie.finalize!
        end

        def finalize!
          namespace.const_set(:Container, container)
          container.config.name = name
          container.finalize!
        end

        def name
          namespace.name.underscore.to_sym
        end

        def namespace
          Object.const_get(::Rails.application.class.to_s.split('::').first)
        end

        def container
          Railtie.config.container
        end
      end
    end
  end
end
