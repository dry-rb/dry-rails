# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/show/:id" => "users#show"
  get "users/new/:id" => "users#new"
end
