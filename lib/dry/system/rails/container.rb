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

          # This is called when reloading in dev mode
          #
          # @api private
          def refresh_boot_files
            booter.boot_files.each do |boot_file|
              load(boot_file)
            end
            self
          end
        end
      end
    end
  end
end
