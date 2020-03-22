# frozen_string_literal: true

RSpec.describe Dry::Rails::Railtie, '.finalize!' do
  subject(:railtie) { Dry::Rails::Railtie.instance }

  it 'reloads container and import module', no_reload: true do
    Rails.application.reloader.reload!

    Dry::Rails.container do
      auto_register!('app/operations')
    end

    Dummy::Container.register('foo', Object.new)

    Rails.application.reloader.reload!

    expect(Dummy::Container.keys).to_not include('foo')

    klass = Class.new do
      include Dummy::Import['create_user']
    end

    obj = klass.new

    expect(obj.create_user).to be_instance_of(CreateUser)
  end
end
