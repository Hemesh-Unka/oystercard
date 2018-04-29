require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new }

  let(:fake_entry_station) { double(name: 'Hayes & Harlington', zone: 5) }
  let(:fake_journey_class) { double }

  describe '#initialize' do
    # it 'initalizes a new journey class on instance' do
    #   expect(journey_log.journey).to be_an_instance_of Journey
    # end

    it 'has a nil value for entry station' do
      expect(journey_log.entry_station).to be_nil
    end

    it 'log array to be empty' do
      expect(journey_log.log).to be_empty
    end
  end

  describe '#start' do
    it 'should start a new journey with an entrance station' do
      expect { journey_log.start(fake_entry_station) }.to change { journey_log.entry_station }.from(nil)
    end
  end
end
