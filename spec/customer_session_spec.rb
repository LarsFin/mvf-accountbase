require_relative '../lib/customer_session.rb'

describe CustomerSession do

  acc1 = {
    'id'=>'100',
    'firstname' => 'test',
    'lastname' => 'testlastname',
    'email' => 'testemail',
    'telephone' => '7357',
    'balance' => '-0.99'
  }

  acc2 = {
    'id'=>'105',
    'firstname' => 'test2',
    'lastname' => 'doggo',
    'email' => 'testemail2',
    'telephone' => '9999',
    'balance' => '100.00'
  }

  acc3 = {
    'id'=>'888',
    'firstname' => 'test3',
    'lastname' => 'testlastname3',
    'email' => 'testemail3',
    'telephone' => '0033',
    'balance' => '-2000.00'
  }

  account_list = [acc1, acc2, acc3]

  subject { described_class.new(account_list) }

  describe '#Instantiation' do
    it 'Is instantiated with an accounts attribute that can be set' do
      expect(subject.accounts).to eq(account_list)
    end
  end

  describe '#get_contact_information' do
    it 'Should get the information of the specified account' do
      expect(subject.get_contact_information('105')).to eq(['test2', 'doggo', 'testemail2', '9999'])
    end

    it 'Should return false if an account matching the id does not exist' do
      expect(subject.get_contact_information('NotThere')).to eq(false)
    end
  end

  describe '#overdrawn_accounts' do
    it 'Should return an array of the ids and balances of accounts that have been overdrawn' do
      expect(subject.overdrawn_accounts).to eq([['100', '-0.99'],['888', '-2000.00']])
    end
  end

end
