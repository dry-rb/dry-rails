# frozen_string_literal: true

RSpec.describe Dry::Rails::Features::SafeParams do
  describe "#resolve" do
    context "with ApplicationController" do
      subject(:controller) do
        ApplicationController.new
      end

      it "resolves container component" do
        expect(controller.resolve(:mailer)).to be_instance_of(Mailer)
      end
    end

    context "with ActionController::API" do
      subject(:controller) do
        ActionController::API.new
      end

      it "resolves container component" do
        expect(controller.resolve(:mailer)).to be_instance_of(Mailer)
      end
    end
  end
end
