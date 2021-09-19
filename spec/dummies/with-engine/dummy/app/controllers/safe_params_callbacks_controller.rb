# frozen_string_literal: true

class SafeParamsCallbacksController < ApplicationController
  before_action do
    if safe_params&.failure?
      head 422
    else
      head 200
    end
  end

  schema(:show) do
    required(:id).value(:integer)
  end

  def show
  end
end
