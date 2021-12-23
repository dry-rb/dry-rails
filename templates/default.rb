# frozen_string_literal: true

gem "dry-rails", github: "dry-rb/dry-rails"

initializer "system.rb", <<-CODE
  Dry::Rails.container do
    # cherry-pick features
    config.features = %i[application_contract]

    # enable auto-registration in the lib dir
    # config.component_dirs.add "lib" do |dir|
    #   dir.namespaces.add "my_super_cool_app", key: nil
    # end
  end
CODE
