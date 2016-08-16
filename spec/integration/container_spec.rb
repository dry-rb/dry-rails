RSpec.describe 'Application container' do
  describe '#load_component' do
    it 'loads component by its identifier' do
      Dummy::Container.load_component('user_repo')

      expect(Object.const_defined?(:UserRepo)).to be(true)
    end
  end
end
