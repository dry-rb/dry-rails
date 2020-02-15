# frozen_string_literal: true

RSpec.describe Dry::Rails::Core::ApplicationContract do
  subject(:contract) do
    Class.new(Dummy::ApplicationContract) do
      schema do
        required(:name).filled(:string)
      end
    end.new
  end

  it 'preconfigures subclasses to use localized messages' do
    I18n.with_locale(:en) do
      expect(contract.(name: '').errors[:name])
        .to eql(['cannot be blank'])
    end
  end

  it 'enables all locales via I18n' do
    I18n.with_locale(:pl) do
      expect(contract.(name: '').errors[:name]).to eql(['nie może być puste'])
    end
  end
end
