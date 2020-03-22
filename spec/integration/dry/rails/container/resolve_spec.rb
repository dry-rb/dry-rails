# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, ".[]" do
  subject(:system) { Dummy::Container }

  context "with auto-registration" do
    before(:all) do
      Dry::Rails.container do
        auto_register!("app/operations")
      end
    end

    it "returns an auto-registered component" do
      expect(system["create_user"]).to be_instance_of(CreateUser)
    end
  end
end
