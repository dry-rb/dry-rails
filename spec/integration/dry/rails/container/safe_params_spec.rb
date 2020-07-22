# frozen_string_literal: true

RSpec.describe Dry::Rails::Features::SafeParams do
  describe ".schema" do
    context "with ApplicationController" do
      subject(:controller) do
        ApplicationController.new
      end

      before do
        ApplicationController.schema(:show, :edit) do
          required(:id).filled(:integer)
        end
      end

      it "defines a schema for specific actions" do
        %i[show edit].each do |action|
          expect(controller.schemas[action].(id: "1")).to be_success
          expect(controller.schemas[action].(id: "foo")).to be_failure
        end
      end
    end

    context "with ActionController::API" do
      subject(:controller) do
        ActionController::API.new
      end

      before do
        ActionController::API.schema(:show, :edit) do
          required(:id).filled(:integer)
        end
      end

      it "defines a schema for specific actions" do
        %i[show edit].each do |action|
          expect(controller.schemas[action].(id: "1")).to be_success
          expect(controller.schemas[action].(id: "foo")).to be_failure
        end
      end
    end
  end
end
