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

  describe '#deduct' do
    it 'should deduct the balance by the specified amount' do
      oystercard.top_up(1)
      oystercard.deduct(1)
      expect(oystercard.balance).to eq(0)
    end
  end

  describe 'touch in/out' do
    describe '#in_journey?' do
      it 'should return false if not in journey' do
        expect(oystercard.in_journey?).to eq(false)
      end
    end

    describe '#touch_in' do
      it 'should return true if touched in' do
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'should return false if touched out' do
        oystercard.touch_in
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end
    end
  end
end
