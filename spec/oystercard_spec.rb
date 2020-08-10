require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      amount = 5
      expect { subject.top_up amount }.to change { subject.balance }.by amount
    end

    it 'raises an error when the limit is exceeded' do
      max_balance = Oystercard::CARD_LIMIT
      subject.top_up max_balance
      expect { subject.top_up 1 }.to raise_error "Unable to exceed card limit of: #{max_balance}"
    end
  end

  describe '#deduct' do
    
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct the balance' do
      subject.top_up 10
      expect { subject.deduct 5 }.to change { subject.balance }.by amount
    end
  end
end