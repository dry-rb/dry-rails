# frozen_string_literal: true

RSpec.describe Dry::Rails::Railtie, '.finalize!' do
  subject(:railtie) { Dry::Rails::Railtie.instance }

  before(:all) do
    Dry::Rails.container do
      auto_register!('app/operations')
    end
  end

  it 'reloads container and import module', no_reload: true do
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
