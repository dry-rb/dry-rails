RSpec.describe Dry::System::Rails::Railtie do
  subject(:railtie) do
    Dry::System::Rails::Railtie.instance
  end

  describe '.finalize!' do
    let(:container) do
      railtie.container
    end

    let(:import) do
      railtie.import
    end

    it 'reloads container and import module' do
      container.register(:foo, Object.new)

      railtie.finalize!

      expect(container.keys).to_not include(:foo)

      klass = Class.new
      klass.include(import['operations.create_user'])

      obj = klass.new

      expect(obj.create_user).to be_instance_of(Operations::CreateUser)
    end
  end
end
