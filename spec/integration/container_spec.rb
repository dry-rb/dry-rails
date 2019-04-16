# frozen_string_literal: true

RSpec.describe 'Application container' do
  subject(:system) { Dummy::Container }

  describe '#load_component' do
    it 'loads component by its identifier' do
      system.load_component('user_repo')

      expect(Object.const_defined?(:UserRepo)).to be(true)
    end
  end

  describe '#[]' do
    it 'returns auto-registered component' do
      expect(system['operations.create_user']).to be_instance_of(Operations::CreateUser)
    end
  end

  describe '#auto_register!' do
    it 'auto-registers files based on config' do
      mailer_worker = Dummy::Container['workers.mailer_worker']

      expect(mailer_worker).to be_instance_of(Workers::MailerWorker)
      expect(Dummy::Container['workers.mailer_worker']).to be(mailer_worker) # memoized
      expect(mailer_worker.mailer).to be_instance_of(Mailer)
    end
  end
end
