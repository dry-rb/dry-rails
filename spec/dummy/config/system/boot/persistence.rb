# frozen_string_literal: true

Dummy::Container.boot(:persistence) do |container|
  start do
    container.register("persistence.db", :i_am_db)
  end
end
