class Oystercard
  CARD_LIMIT = 90
  MININUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station, :history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def top_up(amount)
    raise 'Card limit exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    true unless @entry_station.nil?
  end

  def touch_in(entry_station)
    raise 'Insufficent funds, please top up' if @balance < MININUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MININUM_BALANCE)
    @exit_station = exit_station
    @history << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
