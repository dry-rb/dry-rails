# frozen_string_literal: true

RSpec.describe 'Using dry-system plugins' do
  xit 'with extra settings inside the initializer container block' do
    # TODO: this requires an improvement in dry-system so that
    #       it no longer uses `configure` as a hook for plugins

    Dry::Rails.container do
      use :env, inferrer: -> { Rails.env }
    end

    expect(Dummy::Container.env).to be(Rails.env.to_sym)
  end
end
