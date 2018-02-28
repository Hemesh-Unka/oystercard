class Oystercard
  CARD_LIMIT = 90
  MININUM_BALANCE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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

  def touch_out
    deduct(MININUM_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
