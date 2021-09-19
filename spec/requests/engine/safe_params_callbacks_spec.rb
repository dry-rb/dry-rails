# frozen_string_literal: true

RSpec.describe "SuperEngine::SafeParamsCallbacksController", :engine, type: :request do
  describe "GET /safe_params_callbacks/show" do
    it "returns a successful response code" do
      get "/super_engine/safe_params_callbacks/show/312"

      expect(response).to have_http_status(200)
    end

    it "returns errors" do
      get "/super_engine/safe_params_callbacks/show/oops"

      expect(response).to have_http_status(422)
    end
  end
end
