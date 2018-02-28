require_relative '../lib/app.rb'

describe App do

  let(:account_session_class) { double('account_session_class', new: 'new called') }
  subject { described_class.new(account_session_class) }

  describe 'App instantiation' do
    describe '#App_accounts' do
      it 'App should be initialised with an array set to an attirbute "accounts"' do
        expect(subject.accounts).to be_a Array
      end

      it 'Should be able to read real data from an account in accounts array' do
        expect(subject.accounts[0]["firstname"]).to eq("Izayah")
      end
    end

    describe '#App_account_session_class' do
      it 'App can be passed a parameter upon instantiation that is set to an "account_session_class" attr' do
        expect(subject.account_session_class).to eq(account_session_class)
      end
    end
  end

  describe '#create_account_session' do
    it 'Should call the instantiation of a new instance of "account_session_class" with a valid id given' do
      expect(subject.create_account_session('861fc585-3313-4928-891d-c8711dfe3f8a')).to eq('new called')
    end

    it 'Should not call the instantiation if a non matching guid is given' do
      expect(subject.create_account_session('notrealguid')).to_not eq('new called')
    end
  end

end
