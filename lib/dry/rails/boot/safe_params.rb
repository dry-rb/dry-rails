# frozen_string_literal: true

Dry::System.register_component(:safe_params, provider: :rails) do
  init do
    require 'dry/rails/core/safe_params'
  end

  start do
    ApplicationController.include(Dry::Rails::Core::SafeParams)
  end
end
