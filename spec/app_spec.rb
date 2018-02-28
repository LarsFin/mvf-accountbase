require_relative '../lib/app.rb'

describe App do

  subject { described_class.new }

  describe '#App_accounts' do
    it 'App should be initialised with an array set to an attirbute "accounts"' do
      expect(subject.accounts).to be_a Array
    end

    it 'Should be able to read real data from an account in accounts array' do
      expect(subject.accounts[0]["firstname"]).to eq("Izayah")
    end
  end

  describe '#verify_id' do
    it 'Should return false if id does not match an account\'s' do
      expect(subject.verify_id('notrealguid')).to eq(false)
    end

    it 'Should return true if id matches the id of an account' do
      expect(subject.verify_id('861fc585-3313-4928-891d-c8711dfe3f8a')).to eq(true)
    end
  end

end
