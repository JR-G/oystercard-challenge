require 'oystercard'

describe Oystercard do
  let(:amount) { 5 }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    context 'has been topped up' do
      before do
        subject.top_up Oystercard::CARD_LIMIT
      end

      it 'raises an error when the limit is exceeded' do
        expect { subject.top_up 1 }.to raise_error "Unable to exceed card limit of: #{Oystercard::CARD_LIMIT}"
      end
    end

    it 'can top up the balance' do
      expect { subject.top_up amount }.to change { subject.balance }.by amount
    end
  end


  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    context 'has touched in with a balance' do
      before do
        subject.top_up amount
        subject.touch_in(entry_station)
      end

      xit 'stores the entry station' do
        expect(subject.entry_station).to eq entry_station
      end
    end

    context 'has not been topped up' do
      it 'throws an error' do
        expect { subject.touch_in(entry_station) }.to raise_error "Insufficient balance"
      end
    end
  end


  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
      
    context 'has touched out' do
      before do
        subject.top_up amount
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end

      xit 'stores the exit station' do
        expect(subject.exit_station).to eq exit_station
      end

      it 'charges the card' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
      end
    end
  end
end