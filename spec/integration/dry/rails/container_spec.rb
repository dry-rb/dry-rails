# frozen_string_literal: true

require "logger"

RSpec.describe Dry::Rails, ".container" do
  subject(:system) { Dummy::Container }

  before(:all) do
    Dry::Rails.container do
      config.auto_inject_constant = "CustomImport"
      register(:logger, Logger.new($stdout))
    end

    Dry::Rails::Railtie.reload
  end

  it "allows setting up the container in multiple steps" do
    expect(system.config.default_namespace).to eql("dummy")
    expect(system[:logger]).to be_instance_of(Logger)
  end

  it "allows setting up a custom import constant name" do
    expect(system.config.auto_inject_constant).to eql("CustomImport")
    expect(Dummy).to be_const_defined :CustomImport
  end
end
