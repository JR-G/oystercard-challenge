require 'journey'

describe Journey do
  let(:first_station) { double :station, zone: 1}
  let(:second_station) { double :second_station, zone: 1 }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  describe '#initialized' do
    it 'has an empty station' do
      expect(subject.entry_station).to be_nil
    end
  end

  context 'given an entry station' do
    subject {described_class.new first_station }

    it 'has an entry station' do
      expect(subject.entry_station).to eq first_station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  context 'given an exit station' do
    before do
      subject.finish(second_station)
    end

    it 'calculates a fare' do
      expect(subject.fare).to eq 1
    end

    it 'knows if a journey is complete' do
      expect(subject).to be_complete
    end
  end
end