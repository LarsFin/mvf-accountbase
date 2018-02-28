require_relative '../lib/app.rb'

describe App do

  subject { described_class.new }

  describe '#App_accounts' do
    it 'App should be initialised with an array set to an attirbute "accounts"' do
      expect(subject.accounts).to be_a Array
    end

    it 'Should be able to read real data from an account in accounts array' do
      expect(subject.accounts[0][:firstname]).to equal("Izayah")
    end
  end

end
