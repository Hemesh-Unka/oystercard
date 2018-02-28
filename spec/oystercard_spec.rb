require 'oystercard'

describe Oystercard do
  subject(:oyster) { described_class.new }
  let(:fake_entry_station) { double('Liverpool Street') }
  let(:fake_exit_station) { double('Hayes & Harlington') }

  before(:each) do
    oyster.top_up(1)
    oyster.touch_in(fake_entry_station)
  end

  describe 'balance' do
    it 'expects a new instance of oyster class to have a balance of 0' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should update the balance with the specified top up amount' do
      expect(oyster.balance).to eq(1)
    end
    it 'should raise an error if card limit (£90) is reached' do
      card_limit = Oystercard::CARD_LIMIT
      error_message = 'Card limit exceeded'
      expect { oyster.top_up(card_limit + 1) }.to raise_error(error_message)
    end
  end

  describe '#deduct' do
    it 'should deduct the balance by the specified amount' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.balance).to eq(0)
    end
  end

  describe 'touch in' do
    describe '#in_journey?' do
      it 'should return false if not in journey' do
        oyster.touch_out(fake_exit_station)
        expect(oyster.in_journey?).to be_nil
      end
    end

    describe '#touch_in' do
      it 'should return true if touched in' do
        expect(oyster).to be_in_journey
      end

      it 'should log the entry station on touch in' do
        expect(oyster.entry_station).to eq fake_entry_station
      end

      it 'should raise and error if balance is less than mininum limit (£1)' do
        error_message = 'Insufficent funds, please top up'
        oyster.touch_out(fake_exit_station)
        expect { oyster.touch_in(fake_entry_station) }.to raise_error(error_message)
      end
    end
  end

  describe 'touch out' do
    describe '#touch_out' do
      it 'should return false if touched out' do
        oyster.touch_out(fake_exit_station)
        expect(oyster).not_to be_in_journey
      end

      it 'should log the exit station on touch out' do
        oyster.touch_out(fake_exit_station)
        expect(oyster.exit_station).to eq fake_exit_station
      end

      it 'should charge the mininum fare on touch out' do
        expect { oyster.touch_out(fake_exit_station) }.to change { oyster.balance }.by(-1)
      end
    end
  end

  describe 'history' do
    it 'should have a empty history on object instance' do
      expect(oyster.history).to be_empty
    end

    it 'on touch out, history should contain a hash of touch in/out stations' do
      oyster.touch_out(fake_exit_station)
      expect(oyster.history).to eq [{ entry_station: fake_entry_station, exit_station: fake_exit_station }]
    end
  end
end
