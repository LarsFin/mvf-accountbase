require_relative '../lib/account_session.rb'

describe AccountSession do

  details = {
    "id"=>"testid",
    "firstname" => "testname",
    "lastname" => "testlastname",
    "email" => "testemail",
    "telephone" => "7357"
  }

  subject { described_class.new(details)}

  describe '#instantiation' do
    it 'Should be instantiated with details that are set to an attribute "details"' do
      expect(subject.details).to eq(details)
    end
  end

end
