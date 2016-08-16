require 'dry/system/container'
require 'rails/railtie'

module Dry
  module System
    module Rails
      extend Dry::Configurable

      setting :namespace

      def self.configure
        return if config.namespace
        super
        config.namespace.const_set(:Container, create_container(config.namespace))
      end

      def self.create_container(namespace)
        container = Class.new(Dry::System::Container).configure do |config|
          config.root = ::Rails.root
          config.system_dir = config.root.join('config/system')
          config.name = namespace.to_s.underscore.to_sym
        end

        container.load_paths!('lib', 'app/models')
      end

      class Railtie < ::Rails::Railtie
        config.before_initialize do |app|
        end

        config.to_prepare do |config|
        end
      end
    end
  end
end
