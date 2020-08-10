class Oystercard
  attr_reader :balance

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


  private

  def exceed_limit?(value)
    @balance + value > CARD_LIMIT
  end
end