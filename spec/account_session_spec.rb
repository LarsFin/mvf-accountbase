require_relative '../lib/account_session.rb'

describe AccountSession do

  subject { described_class.new({
    "id"=>"testid",
    "firstname" => "testname",
    "lastname" => "testlastname",
    "email" => "testemail",
    "telephone" => "7357"
    })}

  describe '#instantiation' do
    it 'Should be instantiated with details that are set to an attribute "details"' do
      expect(subject.details).to be_a Hash
    end
  end

end
