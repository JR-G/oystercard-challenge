require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Unable to exceed card limit of: #{CARD_LIMIT}" if exceed_limit? amount

    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if sufficient_funds?

    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station = nil)
    @journey.finish(exit_station)
    deduct(@journey.fare)
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
