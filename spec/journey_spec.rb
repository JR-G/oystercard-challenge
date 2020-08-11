require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}

  it { is_expected.to respond_to :finish }
  it { is_expected.to respond_to :fare }
  it { is_expected.to respond_to :complete? }

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  describe '#initialized' do
    it 'has an empty station' do
      expect(subject.entry_station).to be_nil
    end
  end

  context 'given an entry station' do
    subject {described_class.new station }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end
  end
end