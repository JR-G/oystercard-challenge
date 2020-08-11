class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
  end

  def fare
    exit_station == nil ? PENALTY_FARE : 1
  end

  def complete?
    @entry_station && @exit_station
  end
end