# frozen_string_literal: true

RSpec.describe Dry::Rails::Features::SafeParams do
  subject(:controller) do
    ApplicationController.new
  end

  describe "#resolve" do
    it "resolves container component" do
      expect(controller.resolve(:mailer)).to be_instance_of(Mailer)
    end
  end
end
