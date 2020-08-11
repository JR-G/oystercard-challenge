require 'journeylog'

describe JourneyLog do
  let(:first_station) { double :first_station, zone: 1 }
  let(:second_station) { double :second_station, zone: 1 }

  let(:journey) { double :journey }
  let(:journey_class) { double :journey_class, new: journey }
  subject { described_class.new journey_class: journey_class }

  

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(entry_station: first_station)
      subject.start first_station
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start first_station
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
  end


  describe '#journeys' do
    it 'returns an array' do
      expect(subject.journeys).to be_kind_of Array
    end
  end
end