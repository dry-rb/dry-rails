require 'dry/system/container'
require 'rails/railtie'

module Dry
  module System
    module Rails
      extend Dry::Configurable

      setting :namespace
      setting :auto_register, []

      def self.configure
        return if config.namespace
        super
        container = create_container(config)
        config.namespace.const_set(:Container, container)

        Railtie.configure do |r|
          r.config.container = container
        end
      end

      def self.create_container(defaults)
        namespace = defaults.namespace
        auto_register = defaults.auto_register

        container = Class.new(Dry::System::Container).configure do |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.name = namespace.to_s.underscore.to_sym
          config.auto_register = auto_register
        end

        container.load_paths!('lib', 'app', 'app/models')
      end

      class Railtie < ::Rails::Railtie
        config.to_prepare do |config|
          Railtie.config.container.finalize!
        end
      end
    end
  end
end
