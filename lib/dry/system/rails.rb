require 'dry/system/container'
require 'rails/railtie'

module Dry
  module System
    module Rails
      class Railtie < ::Rails::Railtie
        config.before_initialize do |app|
        end

        config.to_prepare do |config|
        end
      end
    end
  end
end
