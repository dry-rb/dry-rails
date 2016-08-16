require 'dry/system/rails'

module Dummy
  class Container < Dry::System::Container
    configure do |config|
      config.name = :dummy
      config.root = Pathname(__dir__).join('../..')
      config.system_dir = config.root.join('config/system')
    end

    load_paths!('lib')
  end
end
