# frozen_string_literal: true

RSpec.describe Dry::Rails::Container, '.auto_register!' do
  subject(:system) { Dummy::Container }

  before do
    Dry::Rails.container { auto_register!('foo', strategy: :not_here) }
  end

  after do
    Dry::Rails.instance_variable_set('@_container_blocks', [])
  end

  it 'raises a meaningful error when invalid name was passed' do
    expect {
      Dry::Rails::Railtie.reload
    }.to raise_error(Dry::Rails::InvalidAutoRegistrarStrategy, /not_here/)
  end
end
