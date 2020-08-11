require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
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

  def touch_in(entry_station)
    fail "Insufficient balance" if sufficient_funds?

    @entry_station = entry_station
    @journey_hold = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    record_journey
    reset_entry_station
  end

  def in_journey?
    !!entry_station
  end

  private
  
  def record_journey
    journeys << { :entry_station => @entry_station, :exit_station => @exit_station }
  end

  def reset_entry_station
    @entry_station = nil
  end

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
