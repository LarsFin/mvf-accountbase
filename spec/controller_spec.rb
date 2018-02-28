require_relative '../lib/controller'

describe Controller do

  let(:app_class) { double('app_class', new: 'new called') }
  subject { described_class.new(app_class, '1', '2', '3') }

  describe '#instantiation' do
    it 'should be initialised with an app_class which it creates a new instance of' do
      expect(app_class).to receive(:new).with('1', '2', '3')
      Controller.new(app_class, '1', '2', '3')
    end

    it 'should be instantiated with a current_user attribute that is nil' do
      expect(subject.current_user).to be(nil)
    end
  end

  # describe '#run_app' do
  #   it 'should output welcome message, then follow up with question' do
  #     subject.stub(:gets) {'quit'}
  #     expect { subject.run }.to output("Welcome\nAre you an account holder?\n").to_stdout
  #   end
  # end

  # describe '#quit' do
  #   it 'should output welcome message' do
  #     expect { subject.quit }.to output("Thankyou,\nclosing...\n").to_stdout
  #   end
  # end

  describe '#evaluate' do
    describe 'positive' do
      it 'should return true if you type in "YES"' do
        expect(subject.evaluate("YES")).to be(true)
      end

      it 'should return true if you type in "yes"' do
        expect(subject.evaluate("yes")).to be(true)
      end

      it 'should return true if you type in "y"' do
        expect(subject.evaluate("y")).to be(true)
      end
    end

    describe 'negative' do
      it 'should return true if you type in "NO"' do
        expect(subject.evaluate("NO")).to be(false)
      end

      it 'should return true if you type in "no"' do
        expect(subject.evaluate("no")).to be(false)
      end

      it 'should return true if you type in "n"' do
        expect(subject.evaluate("n")).to be(false)
      end
    end

    # describe 'quit/exit' do
    #   it 'should call exit if you type in "exit"' do
    #     expect(subject).to receive(:quit)
    #     subject.evaluate('exit')
    #   end
    #
    #   it 'should call exit if you type in "quit"' do
    #     expect(subject).to receive(:quit)
    #     subject.evaluate('quit')
    #   end
    # end

    describe 'unrecognisable' do
      it 'should call the resort if an unrecognised input is made' do
        expect(subject.evaluate('gibberish.. mumble mumble..')).to eq('not-recognisable')
      end
    end
  end

end
