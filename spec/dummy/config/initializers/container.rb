require 'dry/system/rails'

Dry::System::Rails.configure do |config|
  config.namespace = Dummy
  config.auto_register << 'app/operations'
end
