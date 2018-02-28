require_relative '../lib/app.rb'

describe App do

  let(:account_session_class) { double('account_session_class', new: 'new called') }
  let(:customer_session_class) { double('customer_session_class', new: 'new called') }
  subject { described_class.new(account_session_class, customer_session_class) }

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

      it 'App can be passed a second parameter upon instantiation that is set to a "customer_session_class" attr' do
        expect(subject.customer_session_class).to eq(customer_session_class)
      end
    end
  end

  describe '#create_account_session' do
    it 'Should call the instantiation of a new instance of "account_session_class" with a valid id given' do
      expect(account_session_class).to receive(:new)
      subject.create_account_session('861fc585-3313-4928-891d-c8711dfe3f8a')
    end

    it 'Should not call the instantiation if a non matching guid is given' do
      expect(account_session_class).not_to receive(:new)
      subject.create_account_session('notrealguid')
    end

    it "Should call instantiation with the details of the user matching the id" do
      expect(account_session_class).to receive(:new).with({"id" => "861fc585-3313-4928-891d-c8711dfe3f8a","firstname" => "Izayah","lastname" => "Hayden","email" => "Izaya.HAY6958@yopmail.com","telephone" => "01035 837401","balance" => "8,759.84"})
      subject.create_account_session('861fc585-3313-4928-891d-c8711dfe3f8a')
    end
  end

  describe '#create_customer_session' do
    it 'Should call the instantiation of a new instance of "customer_session_class"' do
      expect(customer_session_class).to receive(:new)
      subject.create_customer_session
    end
  end

  describe '#build_url' do
    it 'Should return the url with the key added to end' do
      expect(subject.build_url('test_kettle')).to eq('https://mvf-devtest-s3api.s3-eu-west-1.amazonaws.com/test_kettle')
    end
  end

  describe '#get_account_base' do
    it 'Should make a request to the uri and retrieve the correct body' do
      expect(subject.get_account_base('key1')).to eq('{"accounts":[{"id":"861fc585-3313-4928-891d-c8711dfe3f8a","firstname":"Izayah","lastname":"Hayden","email":"Izaya.HAY6958@yopmail.com","telephone":"01035 837401","balance":"8,759.84"}]}')
    end

    it 'A different key should get the correct account base according to that key' do
      expect(subject.get_account_base('key3')).to eq('{"accounts":[{"id":"testid2","firstname":"test2","lastname":"testln2","email":"testemail2","telephone":"test","balance":"9.00"}]}')
    end
  end

  describe '#parse' do
    it 'Should parse the JSON to get a ruby hash' do
      expect(subject.parse('{"accounts":[{"id":"861fc585-3313-4928-891d-c8711dfe3f8a","firstname":"Izayah","lastname":"Hayden","email":"Izaya.HAY6958@yopmail.com","telephone":"01035 837401","balance":"8,759.84"}]}')).to be_a Hash
    end
  end

end
