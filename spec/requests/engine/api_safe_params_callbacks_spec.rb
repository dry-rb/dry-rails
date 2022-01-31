# frozen_string_literal: true

RSpec.describe "SuperEngine::ApiSafeParamsCallbacksController", :engine, type: :request do
  describe "GET /api/safe_params_callbacks/show" do
    it "returns a successful response code" do
      get "/super_engine/api/safe_params_callbacks/show/312"

      expect(response).to have_http_status(200)
    end

    it "returns errors" do
      get "/super_engine/api/safe_params_callbacks/show/oops"

      expect(response).to have_http_status(422)
    end
  end
end
