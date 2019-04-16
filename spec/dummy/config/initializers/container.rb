# frozen_string_literal: true

require 'dry/system/rails'

Dry::System::Rails.container do
  config.auto_register << 'app/operations'
end
