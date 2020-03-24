# frozen_string_literal: true

Dry::System.register_component(:controller_helpers, provider: :rails) do
  init do
    require "dry/rails/core/controller_helpers"
  end

  start do
    ApplicationController.include(Dry::Rails::Core::ControllerHelpers)
  end
end
