# frozen_string_literal: true

Dry::System.register_component(:controller_helpers, provider: :rails) do
  init do
    require "dry/rails/features/controller_helpers"
  end

  start do
    unless ApplicationController.include?(Dry::Rails::Features::ControllerHelpers)
      ApplicationController.include(Dry::Rails::Features::ControllerHelpers)
    end

    if defined?(ActionController::API) &&
       !ActionController::API.include?(Dry::Rails::Features::ControllerHelpers)
      ActionController::API.include(Dry::Rails::Features::ControllerHelpers)
    end
  end
end
