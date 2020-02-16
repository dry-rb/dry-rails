# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/components'

require 'dry/rails/errors'
require 'dry/rails/auto_registrar_strategies'

module Dry
  module Rails
    # Customized Container class for Rails application
    #
    # @api public
    class Container < System::Container
      setting :auto_register_configs, [], &:dup
      setting :features, %i[application_contract], reader: true

      AUTO_REGISTER_STRATEGIES = {
        default: -> system { system.config.auto_registrar },
        namespaced: -> _ { AutoRegistrarStrategies::Namespaced }
      }.freeze

      class << self
        # Auto register files from the provided directory
        #
        # @api public
        def auto_register!(dir, options = {}, &block)
          if options.any? || block
            config.auto_register_configs << [dir, options, block]
          else
            config.auto_register << dir
          end

          self
        end

        # @api private
        def finalize!(options = {})
          config.auto_register_configs.each do |(dir, opts, block)|
            strategy = opts.fetch(:strategy, :default)

            unless AUTO_REGISTER_STRATEGIES.key?(strategy)
              raise InvalidAutoRegistrarStrategy.new(strategy, AUTO_REGISTER_STRATEGIES.keys)
            end

            auto_registrar = AUTO_REGISTER_STRATEGIES[strategy][self]

            auto_registrar.new(self).(dir, &block)
          end

          super
        end

        # Return if a given component was booted
        #
        # @return [Boolean]
        #
        # @api private
        def booted?(name)
          booter.booted.map(&:identifier).include?(name)
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
