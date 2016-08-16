require 'user_repo'

RSpec.describe UserRepo do
  subject(:user_repo) { UserRepo.new }

  it 'has persistence.db injected in' do
    expect(user_repo.db).to be(Dummy::Container['persistence.db'])
  end
end
