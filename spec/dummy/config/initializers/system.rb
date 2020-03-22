# frozen_string_literal: true

require 'dry/rails'

Dry::Rails.container do
  auto_register!('lib')
end
