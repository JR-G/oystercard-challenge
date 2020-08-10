class Oystercard
  attr_reader :balance
  attr_accessor :in_journey

  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Unable to exceed card limit of: #{CARD_LIMIT}" if exceed_limit? amount

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  private

  def exceed_limit?(value)
    @balance + value > CARD_LIMIT
  end
end