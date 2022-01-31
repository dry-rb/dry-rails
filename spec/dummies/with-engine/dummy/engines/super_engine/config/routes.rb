# frozen_string_literal: true

SuperEngine::Engine.routes.draw do
  get "books/show/:id" => "books#show"
  get "books/new/:id" => "books#new"

  get "safe_params_callbacks/show/:id" => "safe_params_callbacks#show"

  get "/api/books/show/:id" => "api_books#show"
  get "/api/books/new/:id" => "api_books#new"

  get "/api/safe_params_callbacks/show/:id" => "api_safe_params_callbacks#show"
end
