# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/show/:id" => "users#show"

  get "safe_params_callbacks/show/:id" => "safe_params_callbacks#show"
end
