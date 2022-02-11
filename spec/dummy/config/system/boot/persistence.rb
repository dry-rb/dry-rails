# frozen_string_literal: true

Dummy::Container.register_provider(:persistence) do
  start do
    target.register("persistence.db", :i_am_db)
  end
end
