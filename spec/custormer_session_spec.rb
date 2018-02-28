require_relative '../lib/customer_session.rb'

describe CustomerSession do

  account_list = [1, 2, 3]

  subject { described_class.new(account_list) }

  describe '#Instantiation' do
    it 'Is instantiated with an accounts attribute that can be set' do
      expect(subject.accounts).to eq(account_list)
    end

  end

end
