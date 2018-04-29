require './lib/journey'

class Oystercard
  CARD_LIMIT = 90
  MININUM_BALANCE = 1

  attr_reader :balance, :history, :journey

  def initialize()
    @balance = 0
    @history = []
    @journey = nil
  end

  def top_up(amount)
    raise 'Card limit exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !@journey.nil?
  end

  def touch_in(station = Station.new(name, zone))
    raise 'Insufficent funds, please top up' if @balance < MININUM_BALANCE

    # to clean
    if in_journey?
      deduct(@journey.fare)
      @history << @journey
      @journey = nil
    end

    @journey = Journey.new
    @journey.start(station)
  end

  def touch_out(station = Station.new(name, zone))
    @journey.end(station)
    deduct(@journey.fare)
    @history << @journey
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
