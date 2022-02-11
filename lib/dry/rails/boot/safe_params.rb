# frozen_string_literal: true

Dry::System.register_provider_source(:safe_params, group: :rails) do
  prepare do
    require "dry/rails/features/safe_params"
  end

  start do
    ApplicationController.include(Dry::Rails::Features::SafeParams)

    if defined?(ActionController::API)
      ActionController::API.include(Dry::Rails::Features::SafeParams)
    end
  end
end
