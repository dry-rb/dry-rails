# frozen_string_literal: true

require 'dry/system/rails'

Dry::System::Rails.container do
  config.auto_register << 'lib' << 'app/operations'

  auto_register!('app/workers') do |config|
    config.memoize = true
  end
end
