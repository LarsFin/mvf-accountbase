require_relative '../lib/app.rb'

describe App do

  subject { described_class.new }

  it 'App should be initialised with an array set to an attirbute "accounts"' do
    expect(subject.accounts).to be_a Array
  end

end
