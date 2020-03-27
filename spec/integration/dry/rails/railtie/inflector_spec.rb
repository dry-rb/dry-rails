# frozen_string_literal: true

RSpec.describe Dry::Rails::Railtie, "inflector" do
  it "sets up ActiveSupport::Inflector by default" do
    expect(Dummy::Container[:inflector]).to be(ActiveSupport::Inflector)
  end
end
