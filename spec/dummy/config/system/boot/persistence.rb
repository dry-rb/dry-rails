Dummy::Container.finalize(:persistence) do |container|
  container.register('persistence.db', :i_am_db)
end
