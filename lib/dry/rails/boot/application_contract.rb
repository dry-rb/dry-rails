# frozen_string_literal: true

Dry::System.register_provider_source(:application_contract, group: :rails) do
  prepare do
    require "dry/rails/features/application_contract"
    @railtie = target_container[:railtie]
  end

  start do
    @railtie.set_or_reload(
      :ApplicationContract,
      Class.new(Dry::Rails::Features::ApplicationContract).finalize!(@railtie)
    )
  end

  stop do
    @railtie.remove_constant(:ApplicationContract)
  end
end
