require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe 'balance' do
    it 'expects a new instance of Oystercard class to have a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should update the balance with the specified top up amount' do
      oystercard.top_up(1)
      expect(oystercard.balance).to eq(1)
    end
  end
end
