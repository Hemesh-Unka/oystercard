class Oystercard
  CARD_LIMIT = 90
  MININUM_BALANCE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise 'Card limit exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise 'Insufficent funds, please top up' if @balance < MININUM_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end
end
