class Oystercard
  CARD_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'Card limit exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end
end
