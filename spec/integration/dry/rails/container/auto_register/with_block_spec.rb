# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, ".auto_register!" do
  subject(:system) { Dummy::Container }

  before(:all) do
    Dry::Rails.container do
      auto_register!("app/workers") do |config|
        config.memoize = true
      end
    end
  end

  it "auto-registers files based on block config" do
    mailer_worker = Dummy::Container["mailer_worker"]

    expect(mailer_worker).to be_instance_of(MailerWorker)
    expect(Dummy::Container["mailer_worker"]).to be(mailer_worker) # memoized
    expect(mailer_worker.mailer).to be_instance_of(Mailer)
  end
end
