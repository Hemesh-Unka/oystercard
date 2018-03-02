require 'journey'

describe Journey do

  let(:fake_entry_station) { double(name: 'Hayes & Harlington', zone: 5) }
  let(:fake_exit_station) { double(name: 'Liverpool Street', zone: 1) }

  subject(:journey) { described_class.new }

  describe '#initialize' do
    it 'has a nil value for entry station' do
      expect(journey.entry_station).to be_nil
    end

    it 'has a nil values for exit station' do
      expect(journey.entry_station).to be_nil
    end
  end

  describe '#start' do
    it 'records entry station on touch in' do
      journey.start(fake_entry_station)
      expect(journey.entry_station).to eq fake_entry_station
    end
  end

  describe '#end' do
    it 'records exit station on touch out' do
      journey.end(fake_exit_station)
      expect(journey.exit_station).to eq fake_exit_station
    end
  end

  describe '#fare' do
    it 'should return mininum fare' do
      journey.start(fake_entry_station)
      journey.end(fake_exit_station)
      expect(journey.fare).to eq Journey::MININUM_FARE
    end
  end

  describe '#penalty?' do
    it 'should equal true if user has not touched in or out' do
      expect(journey.penalty?).to eq true
    end

    it 'it should return true if user touches out, but doesnt touch in' do
      journey.end(fake_exit_station)
      expect(journey.penalty?).to eq true
    end

    it 'it should return true if user touches in, but doesnt touch out' do
      journey.start(fake_entry_station)
      expect(journey.penalty?).to eq true
    end

    it 'it should return false if user touches in and out' do
      journey.start(fake_entry_station)
      journey.end(fake_exit_station)
      expect(journey.penalty?).to eq false
    end
  end

  describe '#fare' do
    it 'returns penalty fare if user has not touched out' do
      allow(journey).to receive(:penalty?).and_return(true)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns mininum fare if user has completed a journey' do
      allow(journey).to receive(:penalty?).and_return(false)
      expect(journey.fare).to eq Journey::MININUM_FARE
    end
  end
end
