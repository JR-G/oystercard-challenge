require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'can be topped up' do
    amount = 5
    expect { subject.top_up(amount) }.to change { subject.balance }.by(amount)
  end
  
end