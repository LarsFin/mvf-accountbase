require_relative '../lib/controller'

describe Controller do

  let(:app_class) { double('app_class', new: 'new called') }
  subject { described_class.new(app_class) }

  describe '#instantiation' do
    it 'should be initialised with an app_class which it creates a new instance of' do
      expect(app_class).to receive(:new)
      Controller.new(app_class)
    end
  end

end
