# frozen_string_literal: true

require 'dry/rails'

Dry::Rails.container do
  config.auto_register << 'lib'
end
