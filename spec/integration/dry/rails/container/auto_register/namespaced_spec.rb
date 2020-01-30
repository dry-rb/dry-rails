# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, '.auto_register!' do
  subject(:system) { Dummy::Container }

  context 'when :namespaced strategy is used' do
    before do
      Dry::Rails.container do
        configure do |config|
          config.default_namespace = :dummy
        end

        auto_register!('app/services', strategy: :namespaced)
      end

      Dry::Rails::Railtie.reload
    end

    it 'auto-registers components and uses the app namespace' do
      expect(system['services.github']).to be_instance_of(Dummy::Services::Github)
    end
  end
end
