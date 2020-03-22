# frozen_string_literal: true

RSpec.describe Dry::Rails, ".container" do
  subject(:system) { Dummy::Container }

  before do
    Dry::Rails.container do
      configure do |config|
        config.default_namespace = :dummy
      end
    end

    Dry::Rails.container do
      register(:inflector, Dry::Inflector.new)
    end

    Dry::Rails::Railtie.reload
  end

  it "allows setting up the container in multiple steps" do
    expect(system.config.default_namespace).to be(:dummy)
    expect(system[:inflector]).to be_instance_of(Dry::Inflector)
  end
end
