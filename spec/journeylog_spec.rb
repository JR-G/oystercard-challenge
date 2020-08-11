require 'journeylog'

describe JourneyLog do
  let(:first_station) { double :first_station, zone: 1 }
  let(:second_station) { double :second_station, zone: 1 }

  describe '#initialize' do
    it 'starts a new journey' do
      expect(subject.journey_class).to be kind_of Journey
    end
  end

  it { is_expected.to respond_to :start }

  describe '#start' do
    subject { described_class.new first_station }

    it 'has an entry station' do
      expect(subject.entry_station).to eq first_station
    end
  end

  describe '#finish' do
    subject { described_class.new first_station}

    it 'has an exit station' do
      expect(subject.exit_station).to eq second_station
    end
  end

  describe '#journeys' do
    expect(subject.journeys).to be kind_of Array
  end
end