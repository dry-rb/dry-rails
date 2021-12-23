# frozen_string_literal: true

require "logger"

RSpec.describe Dry::Rails, ".container" do
  subject(:system) { Dummy::Container }

  before(:all) do
    Dry::Rails.container do
      register(:logger, Logger.new($stdout))
    end

    Dry::Rails::Railtie.reload
  end

  before(:each) do
    Dry::Rails.container do
      config.auto_inject_constant = "CustomImport"
    end

    Dry::Rails::Railtie.reload
  end

  after(:each) do
    Dry::Rails.container do
      config.auto_inject_constant = "Deps"
    end

    Dry::Rails::Railtie.reload
  end

  it "allows setting up the container in multiple steps" do
    expect(system[:logger]).to be_instance_of(Logger)
  end

  it "allows setting up a custom import constant name" do
    expect(system.config.auto_inject_constant).to eql("CustomImport")
    expect(Dummy).to be_const_defined :CustomImport
    expect(Dummy).not_to be_const_defined :Deps
  end
end
