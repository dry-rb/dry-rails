# frozen_string_literal: true

RSpec.describe "Environments" do
  subject(:container) { Dummy::Container }

  before do
    Dry::Rails::Railtie.finalize!
  end

  describe ".frozen?" do
    context "when Rails environment is test" do
      it "returns false" do
        expect(container).not_to be_frozen
      end
    end

    context "when Rails environment is not test", :production do
      it "returns true" do
        expect(container).to be_frozen
      end
    end
  end
end
