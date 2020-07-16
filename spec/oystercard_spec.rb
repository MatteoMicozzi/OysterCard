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
  it 'memorize the in station' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    expect {}
  end

  #it 'touch_in' do
    #subject.top_up(Oystercard::MINIMUM_BALANCE)
    #subject.touch_in(station)
    #expect(subject.entry_station).to_not be(nil)
  #end
end
  #it 'touch_out' do
    #subject.touch_out(station)
    #expect(subject.entry_station).to eq(nil)
  #end

  #it 'check if you are in_journey?' do
    #subject.top_up(Oystercard::MINIMUM_BALANCE)
    #subject.touch_in(station)
    #expect(subject.entry_station).not_to eq(nil)
  #end

  it 'raise Error if insufficient balance' do
    expect { subject.touch_in station }.to raise_error("Insufficient balance!")
  end

  it 'check if oystercard is charged' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    expect { subject.touch_out station }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
  end

  #it "saves the station upon touch in" do
    #subject.top_up(Oystercard::MINIMUM_BALANCE)
    #subject.touch_in(station)
    #expect(subject.entry_station).to eq :station
  #end

  it "forgets the station upon touch out" do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end

  #it "saves the exit station upon touch_out" do
    #subject.top_up(Oystercard::MINIMUM_BALANCE)
    #subject.touch_in(station)
    #subject.touch_out(station)
    #expect(subject.journeys).to eq [{touch_in: :station, touch_out: :station}]
  #end

  it 'save an empty list by default' do
    expect(subject.journeys).to eq []
  end

end
