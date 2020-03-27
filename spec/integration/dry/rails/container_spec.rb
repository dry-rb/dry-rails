# frozen_string_literal: true

require "logger"

RSpec.describe Dry::Rails, ".container" do
  subject(:system) { Dummy::Container }

  before do
    Dry::Rails.container do
      register(:logger, Logger.new($stdout))
    end

    Dry::Rails::Railtie.reload
  end

  it "allows setting up the container in multiple steps" do
    expect(system.config.default_namespace).to eql("dummy")
    expect(system[:logger]).to be_instance_of(Logger)
  end
end
