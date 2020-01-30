# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, '.[]' do
  subject(:system) { Dummy::Container }

  context 'without auto-registration' do
    before do
      system.load_component('user_repo')
    end

    it 'returns an explicitly loaded component' do
      user_repo = system['user_repo']

      expect(Object.const_defined?(:UserRepo)).to be(true)
      expect(user_repo).to be_instance_of(UserRepo)
    end
  end

  context 'with auto-registration' do
    before(:all) do
      Dry::Rails.container do
        auto_register!('app/operations')
      end
    end

    it 'returns an auto-registered component' do
      expect(system['operations.create_user']).to be_instance_of(Operations::CreateUser)
    end
  end
end
