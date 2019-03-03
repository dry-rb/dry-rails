require 'dry/system/container'

module Dry
  module System
    module Rails
      class Container < System::Container
        # Use `require_dependency` to make code reloading work
        #
        # @api private
        def self.require_path(path)
          require_dependency(path)
        end
      end
    end
  end
end
