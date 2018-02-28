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
    it 'should raise an error if card limit (£90) is reached' do
      card_limit = Oystercard::CARD_LIMIT
      error_message = 'Card limit exceeded'
      expect { oystercard.top_up(card_limit + 1) }.to raise_error(error_message)
    end
  end
end
