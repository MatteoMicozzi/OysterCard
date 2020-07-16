require 'oystercard'

describe Oystercard do
  let(:station) {:station}
  it 'check the balance in my Oystercard' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  it 'top_up the oystercard' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    expect(subject.balance).to eq(Oystercard::MINIMUM_BALANCE)
  end

  it 'raise an Error if top_up over the limit of 90' do
    subject.top_up(Oystercard::LIMIT)
    expect { subject.top_up Oystercard::MINIMUM_BALANCE }.to raise_error("Reached max limit of #{Oystercard::LIMIT}!")
  end

  describe '#touch_in to memorize station' do
    let(:station) {:station}
    it 'charges penalty fare if user forgot to touch out' do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change{ subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
  end

  it 'raise Error if insufficient balance' do
    expect { subject.touch_in station }.to raise_error("Insufficient balance!")
  end

  it 'save an empty list by default' do
    expect(subject.journeys).to eq []
  end

  describe '#touch_out' do
    let(:station) {:station}

    it 'check if oystercard is charged' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect { subject.touch_out station }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end
  end
end
