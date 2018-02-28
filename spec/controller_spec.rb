require_relative '../lib/controller'

describe Controller do

  let(:app_class) { double('app_class', new: 'new called') }
  subject { described_class.new(app_class, '1', '2', '3') }

  describe '#instantiation' do
    it 'should be initialised with an app_class which it creates a new instance of' do
      expect(app_class).to receive(:new).with('1', '2', '3')
      Controller.new(app_class, '1', '2', '3')
    end
  end

end
