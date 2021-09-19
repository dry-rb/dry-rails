# frozen_string_literal: true

class UsersController < ApplicationController
  schema(:show) do
    required(:id).value(:integer)
  end

  schema(:new) do
    required(:id).value(:integer)
  end

  def show
    if safe_params.success?
      render json: {id: safe_params[:id], name: "Jane"}
    else
      render json: {errors: safe_params.errors.to_h}
    end
  end

  def new
    if safe_params.success?
      render json: {id: safe_params[:id], name: "Jane"}
    else
      render json: {errors: safe_params.errors.to_h}
    end
  end
end
