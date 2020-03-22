# frozen_string_literal: true

Dry::System.register_component(:application_contract, provider: :rails) do
  init do
    require "dry/rails/core/application_contract"
  end

  start do
    railtie.set_or_reload(
      :ApplicationContract,
      Class.new(Dry::Rails::Core::ApplicationContract).finalize!(railtie)
    )
  end

  stop do
    railtie.remove_constant(:ApplicationContract)
  end
end
