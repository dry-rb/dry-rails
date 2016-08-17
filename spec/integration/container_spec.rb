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
end
