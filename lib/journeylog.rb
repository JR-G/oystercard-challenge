class JourneyLog
  attr_reader :journey_class, :journeys

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station = nil)
    @entry_station = entry_station
    add journey_class.new(entry_station: entry_station)
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
  end

  def journeys
    @journeys.dup
  end

  private
  def current_journey
    @current_journey ||= journey_class.new
  end 

  def add(journey)
    @journeys << journey
  end
end