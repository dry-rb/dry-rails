# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, ".auto_register!" do
  subject(:system) { Dummy::Container }

  context "with a single path" do
    before(:all) do
      Dry::Rails.container do
        auto_register!("app/operations")
      end
    end

    it "auto-registers files found under the specified path" do
      create_user = Dummy::Container["create_user"]

      expect(create_user).to be_instance_of(CreateUser)
    end
  end

  context "with multiple paths" do
    before(:all) do
      Dry::Rails.container do
        auto_register!("app/operations", "app/services")
      end
    end

    it "auto-registers files found under the specified paths" do
      create_user = Dummy::Container["create_user"]
      github = Dummy::Container["github"]

      expect(create_user).to be_instance_of(CreateUser)
      expect(github).to be_instance_of(Github)
    end
  end
end
