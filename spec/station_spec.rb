require 'station'

describe Station do
  let(:fake_station) { double('Hayes & Harlington') }
  let(:fake_zone) { double('5') }

  subject(:station) { described_class.new(fake_station, fake_zone) }

  describe '#initialize' do
    it 'has a name & station provided on initialize' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'has a station name' do
      expect(station.name).to eq(fake_station)
    end

    it 'has a zone' do
      expect(station.zone).to eq(fake_zone)
    end
  end
end
