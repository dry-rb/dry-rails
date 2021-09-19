# frozen_string_literal: true

Rails.application.routes.draw do
  mount SuperEngine::Engine, at: "super_engine"

  get "users/show/:id" => "users#show"
  get "users/new/:id" => "users#new"

  get "safe_params_callbacks/show/:id" => "safe_params_callbacks#show"

  get "/api/users/show/:id" => "api_users#show"
  get "/api/users/new/:id" => "api_users#new"

  get "/api/safe_params_callbacks/show/:id" => "api_safe_params_callbacks#show"
end
