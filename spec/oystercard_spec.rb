require 'oystercard'

describe Oystercard do
  let (:amount) { 5 }
  
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
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


  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    context 'has been topped up' do
      before do
        subject.top_up Oystercard::CARD_LIMIT
      end

      it 'can deduct the balance' do
        expect { subject.deduct amount }.to change { subject.balance }.by -amount
      end
    end
  end


  describe '#touch_in' do
    it { is_expected.to respond_to :touch_in }

    context 'had been topped up' do
      before do
        subject.top_up amount
      end

      it 'can start a journey' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end

    context 'has not been topped up' do
      it 'throws an error' do
        expect { subject.touch_in }.to raise_error "Insufficient balance"
      end
    end
  end


  describe '#touch_out' do
    it { is_expected.to respond_to :touch_out }
      
    context 'has previously touched in' do
      before do
        subject.top_up amount
        subject.touch_in
      end

      it 'can end a journey' do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end
end