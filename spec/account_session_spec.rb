require_relative '../lib/account_session.rb'

describe AccountSession do

  details = {
    'id'=>'testid',
    'firstname' => 'testname',
    'lastname' => 'testlastname',
    'email' => 'testemail',
    'telephone' => '7357',
    'balance' => '£0.99'
  }

  subject { described_class.new(details)}

  describe '#instantiation' do
    it 'Should be instantiated with details that are set to an attribute "details"' do
      expect(subject.details).to eq(details)
    end
  end

  describe '#balance' do
    it 'Should return the balance' do
      expect(subject.balance).to eq('£0.99')
    end
  end

  describe '#information' do
    it 'Should return contact information on the account holder' do
      expect(subject.information).to eq(['testname', 'testlastname', 'testemail', '7357'])
    end
  end

end
