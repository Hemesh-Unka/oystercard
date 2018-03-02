class Journey
  attr_reader :entry_station, :exit_station

  MININUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    penalty? ? PENALTY_FARE : MININUM_FARE
  end

  def penalty?
    !@entry_station || !@exit_station
  end
end
