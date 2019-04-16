# frozen_string_literal: true

RSpec.describe Dry::System::Rails::Railtie do
  subject(:railtie) do
    Dry::System::Rails::Railtie.instance
  end

  describe '.finalize!' do
    it 'reloads container and import module' do
      Dummy::Container.register('foo', Object.new)

      Rails.application.reloader.reload!

      expect(Dummy::Container.keys).to_not include('foo')

      klass = Class.new do
        include Dummy::Import['operations.create_user']
      end

      obj = klass.new

      expect(obj.create_user).to be_instance_of(Operations::CreateUser)
    end
  end
end
