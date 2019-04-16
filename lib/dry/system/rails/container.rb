# frozen_string_literal: true

require 'dry/system/container'

module Dry
  module System
    module Rails
      class Container < System::Container
        class << self
          # Use `require_dependency` to make code reloading work
          #
          # @api private
          def require_path(path)
            require_dependency(path)
          end
        end
      end
    end
  end
end
