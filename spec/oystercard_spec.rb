require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:fake_station) { double('Liverpool Street') }

  before(:each) do
    oystercard.top_up(1)
    oystercard.touch_in(fake_station)
  end

  describe 'balance' do
    it 'expects a new instance of Oystercard class to have a balance of 0' do
      oystercard.touch_out
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should update the balance with the specified top up amount' do
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
      oystercard.touch_out
      expect(oystercard.balance).to eq(0)
    end
  end

  describe 'touch in/out' do
    describe '#in_journey?' do
      it 'should return false if not in journey' do
        oystercard.touch_out
        expect(oystercard.in_journey?).to be_nil
      end
    end

    describe '#touch_in' do
      it 'should return true if touched in' do
        expect(oystercard).to be_in_journey
      end

      it 'should log the entry station on touch in' do
        expect(oystercard.entry_station).to eq fake_station
      end

      it 'should raise and error if balance is less than mininum limit (£1)' do
        error_message = 'Insufficent funds, please top up'
        oystercard.touch_out
        expect { oystercard.touch_in(fake_station) }.to raise_error(error_message)
      end
    end

    describe '#touch_out' do
      it 'should return false if touched out' do
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end

      it 'should charge the mininum fare on touch out' do
        expect { oystercard.touch_out }.to change { oystercard.balance }.by(-1)
      end
    end
  end
end
