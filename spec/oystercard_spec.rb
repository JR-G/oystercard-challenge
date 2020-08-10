require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up balance' do
      amount = 5
      expect { subject.top_up(amount) }.to change { subject.balance }.by(amount)
    end
  end
end