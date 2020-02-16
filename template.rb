# frozen_string_literal: true

gem 'dry-rails', github: 'dry-rb/dry-rails'

initializer 'system.rb', <<-CODE
  Dry::Rails.container do
    # cherry-pick features
    config.features = %i[application_contract]

    # enable auto-registration in the lib dir
    # config.auto_register << 'lib'

    # enable auto-registration of custom components
    # auto_register!('app/serializers', strategy: :namespaced)
  end
CODE
