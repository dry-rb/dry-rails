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
      # force auto-registration to run (since we're in test env)
      Dummy::Container.finalize!(freeze: false)

      mailer_worker = Dummy::Container['workers.mailer_worker']

      expect(mailer_worker).to be_instance_of(Workers::MailerWorker)
      expect(Dummy::Container['workers.mailer_worker']).to be(mailer_worker) # memoized
      expect(mailer_worker.mailer).to be_instance_of(Mailer)
    end

    context 'strategies' do
      before do
        Dry::Rails.container { auto_register!('foo', strategy: :not_here) }
      end

      after do
        Dry::Rails.instance_variable_set('@_container_blocks', [])
      end

      it 'raises a meaningful error when invalid name was passed' do
        expect {
          Dry::Rails::Railtie.reload
        }.to raise_error(Dry::Rails::InvalidAutoRegistrarStrategy, /not_here/)
      end
    end
  end
end
