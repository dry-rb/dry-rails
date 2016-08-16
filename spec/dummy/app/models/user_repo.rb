require 'import'

class UserRepo
  include Dummy::Import['persistence.db']
end
