class Oystercard
  CARD_LIMIT = 90
  MININUM_BALANCE = 1

  attr_reader :balance, :in_use, :entry_station

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = entry_station
  end

  def top_up(amount)
    raise 'Card limit exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficent funds, please top up' if @balance < MININUM_BALANCE
    @in_use = true
    @entry_station = entry_station
  end

  def touch_out
    @in_use = false
    deduct(MININUM_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
