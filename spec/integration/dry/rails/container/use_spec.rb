# frozen_string_literal: true

RSpec.describe "Using dry-system plugins" do
  before(:all) do
    Dry::Rails.container do
      use :logging
    end
  end

  it "with extra settings inside the initializer container block" do
    Dummy::Container.configure {}

    expect(Dummy::Container[:logger]).to be_a(Logger)
  end
end
