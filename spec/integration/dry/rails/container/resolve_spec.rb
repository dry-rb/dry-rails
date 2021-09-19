# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, ".[]" do
  subject(:system) { Dummy::Container }

  context "with auto-registration from system initializer" do
    it "returns an auto-registered component" do
      expect(system["create_user"]).to be_instance_of(CreateUser)
      expect(system["github"]).to be_instance_of(Github)
    end

    it "returns auto-registered component with another auto-injected" do
      notifier = system[:notifier]

      expect(notifier).to be_instance_of(Dummy::Notifier)
      expect(notifier.mailer).to be_instance_of(Mailer)
    end

    it "auto-registers files based on block config" do
      mailer_worker = Dummy::Container["mailer_worker"]

      expect(mailer_worker).to be_instance_of(MailerWorker)
      expect(Dummy::Container["mailer_worker"]).to be(mailer_worker) # memoized
      expect(mailer_worker.mailer).to be_instance_of(Mailer)
    end
  end
end
