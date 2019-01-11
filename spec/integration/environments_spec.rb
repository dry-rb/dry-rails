RSpec.describe 'Environments' do
  subject { Dummy::Container }

  describe "frozen?" do
    context 'when Rails environment is test' do
      it { is_expected.not_to be_frozen }
    end

    context 'when Rails environment is not test', :production_env do
      it { is_expected.to be_frozen }
    end
  end
end
