class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  attr_accessor :in_journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Unable to exceed card limit of: #{CARD_LIMIT}" if exceed_limit? amount

    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" if sufficient_funds?

    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    @exit_station = station
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @in_journey = false
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_limit?(value)
    balance + value > CARD_LIMIT
  end

  def sufficient_funds?
    balance < MINIMUM_FARE
  end
end