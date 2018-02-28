require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe 'balance' do
    it 'expects a new instance of Oystercard class to have a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
end
