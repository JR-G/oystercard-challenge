require 'journey'

describe Journey do
  let(:station) { double "station", zone: 1 }
  
  it { is_expected.to respond_to :finish }
  it { is_expected.to respond_to :fare }
  it { is_expected.to respond_to :complete? }
  
  context 'given an entry station' do
    subject { described_class.new(entry_station: station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end
  end
end