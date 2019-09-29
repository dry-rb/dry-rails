RSpec.describe 'Using dry-system plugins' do
  specify 'Using dry-system plugins (which add extra settings) inside the initializer container block' do
    expect(Dummy::Container.env).to eq Rails.env.to_sym
  end
end
