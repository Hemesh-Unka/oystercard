class JourneyLog
  attr_reader :log, :journey, :entry_station

  def initialize(journey = Journey)
    @journey = journey
    @entry_station = nil
    @log = []
  end

  def start(station)
    @entry_station = station
  end
end
