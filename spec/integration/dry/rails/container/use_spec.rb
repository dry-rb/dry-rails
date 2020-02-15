# frozen_string_literal: true

RSpec.describe 'Using dry-system plugins' do
  before(:all) do
    Dry::Rails.container do
      use :env, inferrer: -> { Rails.env }
    end
  end

  it 'with extra settings inside the initializer container block' do
    expect(Dummy::Container.env).to be(Rails.env)
  end
end
