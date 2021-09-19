# frozen_string_literal: true

RSpec.describe Dry::Rails::Railtie, ".finalize!", :main_app do
  subject(:railtie) { Dry::Rails::Railtie.instance }

  it "reloads container and import module", no_reload: true do
    Rails.application.reloader.reload!

    Dry::Rails.container do
      config.component_dirs.add "app/forms"
    end

    Dummy::Container.register("foo", Object.new)

    expect(Dummy::Container.keys).to include("foo")

    Rails.application.reloader.reload!

    expect(Dummy::Container.keys).to_not include("foo")

    klass = Class.new do
      include Dummy::Deps["create_user_form"]
    end

    obj = klass.new

    expect(obj.create_user_form).to be_instance_of(CreateUserForm)
  end
end
