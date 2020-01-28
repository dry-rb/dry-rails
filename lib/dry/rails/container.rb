# frozen_string_literal: true

require 'dry/system/container'

module Dry
  module Rails
    # Customized Container class for Rails application
    #
    # @api public
    class Container < System::Container
      setting :auto_register_configs, [], &:dup

      class << self
        # Auto register files from the provided directory
        #
        # @api public
        def auto_register!(dir, &block)
          if block
            config.auto_register_configs << [dir, block]
          else
            config.auto_register << dir
          end

          self
        end

        # @api private
        def finalize!(options = {})
          config.auto_register_configs.each do |(dir, block)|
            auto_registrar.call(dir, &block)
          end
          super
        end

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
