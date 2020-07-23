# frozen_string_literal: true

RSpec.describe "ApiUsersController", type: :request do
  %w[show new].each do |action|
    describe "GET /api/users/#{action}" do
      it "returns a successful response" do
        get "/api/users/#{action}/312"

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:id]).to be(312)
        expect(json[:name]).to eql("Jane")
      end

      it "returns errors" do
        get "/api/users/#{action}/oops"

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:errors]).to eql(id: ["must be an integer"])
      end
    end
  end
end
