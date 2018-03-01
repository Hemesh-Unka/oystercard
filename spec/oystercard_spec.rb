require 'oystercard'

describe Oystercard do
  subject(:oyster) { described_class.new }
  let(:fake_entry_station) { double('Liverpool Street') }
  let(:fake_exit_station) { double('Hayes & Harlington') }

  before(:each) do
    oyster.top_up(1)
    oyster.touch_in(fake_entry_station)
  end

  describe 'on object instance' do
    it 'card to have a balance of 0' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.balance).to eq(0)
    end

    it 'card history should be empty' do
      expect(oyster.history).to be_empty
    end
  end

  describe '#top_up' do
    it 'balance to update with specified top up amount' do
      expect(oyster.balance).to eq(1)
    end
    it 'raise error if card limit (£90) is reached' do
      card_limit = Oystercard::CARD_LIMIT
      error_message = 'Card limit exceeded'
      expect { oyster.top_up(card_limit + 1) }.to raise_error(error_message)
    end
  end

  describe '#deduct' do
    it 'deduct the balance by the specified amount' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.balance).to eq(0)
    end
  end

  describe '#touch_in' do
    it 'should return true if touched in' do
      expect(oyster).to be_in_journey
    end

    it 'raise error if balance is less than mininum limit (£1)' do
      error_message = 'Insufficent funds, please top up'
      oyster.touch_out(fake_exit_station)
      expect { oyster.touch_in(fake_entry_station) }.to raise_error(error_message)
    end
  end

  describe '#touch_out' do
    it 'returns false on touching out' do
      oyster.touch_out(fake_exit_station)
      expect(oyster).not_to be_in_journey
    end

    it 'charges mininum fare on touch out' do
      expect { oyster.touch_out(fake_exit_station) }.to change { oyster.balance }.by(-1)
    end
  end

  describe '#in_journey?' do
    it 'return true if in journey' do
      oyster.touch_in(fake_exit_station)
      expect(oyster.in_journey?).to be true
    end

    it 'return false if not in journey' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.in_journey?).to be_nil
    end
  end

  describe 'history' do
    it 'logs entry station on touch in' do
      expect(oyster.entry_station).to eq fake_entry_station
    end

    it 'logs exit station on touch out' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.exit_station).to eq fake_exit_station
    end

    it 'on touch out, history should have log of touch in/out stations' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.history).to eq [{ entry_station: fake_entry_station, exit_station: fake_exit_station }]
    end
  end
end
