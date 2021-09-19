# frozen_string_literal: true

RSpec.describe Dry::Rails::Railtie, ".finalize!", :engine do
  subject(:railtie) { Dry::Rails::Railtie.instance }

  it "reloads container and import module", no_reload: true do
    Rails.application.reloader.reload!

    Dry::Rails.container do
      config.component_dirs.add "app/forms"
    end

    Dry::Rails::Engine.container(:super_engine) do
      config.component_dirs.add "app/forms" do |dir|
        dir.default_namespace = "super_engine"
      end
    end

    Dummy::Container.register("foo", Object.new)
    SuperEngine::Container.register("bar", Object.new)

    expect(Dummy::Container.keys).to include("foo")
    expect(SuperEngine::Container.keys).to include("bar")

    Rails.application.reloader.reload!

    expect(Dummy::Container.keys).to_not include("foo")
    expect(SuperEngine::Container.keys).to_not include("bar")

    klass = Class.new do
      include Dummy::Deps["create_user_form"]
      include SuperEngine::Deps["create_book_form"]
    end

    obj = klass.new

    expect(obj.create_user_form).to be_instance_of(CreateUserForm)
    expect(obj.create_book_form).to be_instance_of(SuperEngine::CreateBookForm)
  end
end
