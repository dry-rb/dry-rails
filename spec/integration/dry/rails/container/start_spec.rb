# frozen_string_literal: true

require 'user_repo'

RSpec.describe Dry::Rails::Container, '.start' do
  subject(:user_repo) { UserRepo.new }

  context 'when the system did not start a bootable dep' do
    it 'lazy-loads and starts the dep' do
      expect(user_repo.db).to be(Dummy::Container['persistence.db'])
    end
  end

  context 'when the system started a bootable dep' do
    before do
      Dummy::Container.start(:persistence)
    end

    it 'injects the dep' do
      expect(user_repo.db).to be(Dummy::Container['persistence.db'])
    end
  end
end
