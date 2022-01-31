# frozen_string_literal: true

Dry::System.register_component(:safe_params, provider: :rails) do
  init do
    require "dry/rails/features/safe_params"
  end

  start do
    unless ActionController::Base.include?(Dry::Rails::Features::SafeParams)
      ActionController::Base.include(Dry::Rails::Features::SafeParams)
    end

    if defined?(ActionController::API) &&
       !ActionController::API.include?(Dry::Rails::Features::SafeParams)
      ActionController::API.include(Dry::Rails::Features::SafeParams)
    end
  end
end
