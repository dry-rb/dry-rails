# frozen_string_literal: true

RSpec.describe 'Using dry-system plugins' do
  before do
    pending 'this works but it is flaky as state-between-specs is not fully cleared yet'
  end

  specify 'with extra settings inside the initializer container block' do
    expect(Dummy::Container.env).to be(Rails.env.to_sym)
  end
end
