# frozen_string_literal: true

require 'dry/rails'

Dry::Rails.container do
  use :env, inferrer: -> { Rails.env.to_sym }

  config.auto_register << 'lib' << 'app/operations'

  auto_register!('app/workers') do |config|
    config.memoize = true
  end
end
