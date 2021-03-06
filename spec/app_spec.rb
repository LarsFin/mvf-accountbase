require_relative '../lib/app.rb'

describe App do

  let(:account_session_class) { double('account_session_class', new: 'new called') }
  let(:customer_session_class) { double('customer_session_class', new: 'new called') }
  subject { described_class.new(account_session_class, customer_session_class, ['key1', 'key2', 'key3']) }

  describe 'App instantiation' do
    describe '#App_accounts' do
      it 'App should be initialised with an empty "accounts" attribute' do
        expect(subject.accounts.empty?).to be(true)
      end

      it 'App should be initialised with a "company_guid" attribute that is passed in' do
        expect(subject.company_guid).to eq(['key1', 'key2', 'key3'])
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
    it 'Should call the instantiation of a new instance of "customer_session_class" if key is correct' do
      expect(customer_session_class).to receive(:new)
      subject.create_customer_session('key1')
    end

    it 'Should not call the instantiation of a new instance of "customer_session_class" if key is incorrect' do
      expect(customer_session_class).to_not receive(:new)
      subject.create_customer_session('wrench')
    end
  end

  describe '#get_account_base' do
    it 'Should set the accounts correlating correctly to the guid given' do
      subject.get_account_base('key1')
      expect(subject.accounts).to eq([{"id" => "861fc585-3313-4928-891d-c8711dfe3f8a","firstname" => "Izayah","lastname" => "Hayden","email" => "Izaya.HAY6958@yopmail.com","telephone" => "01035 837401","balance" => "8,759.84"}])
    end
  end

end
