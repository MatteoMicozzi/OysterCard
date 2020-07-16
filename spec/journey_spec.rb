require 'journey'

describe Journey do
  describe '#in_station' do
  let(:station) {:station}
    it 'adds an entry station' do
      subject.enter_station(station)
      expect(subject.in_station).to eq(station)
    end
  end
  describe '#out_station' do
  let(:station) {:station}
    it 'adds an exit station' do
      subject.exit_station(station)
      expect(subject.out_station).to eq(station)
    end
  end
  describe '#in_journey?' do
  let(:station) {:station}
    it 'checks whether the user is in journey or not' do
      subject.enter_station(station)
      expect(subject.in_journey?).to be true
    end
  end
  describe '#fare' do
    let(:station) {:station}
    it 'calculates the minimum fare if touch-in and touch-out completed' do
      subject.enter_station(station)
      subject.exit_station(station)
      expect(subject.fare).to eq(Oystercard::MINIMUM_BALANCE)
    end
    it 'calculates penalty fare if user forgets to touch_in' do
      subject.exit_station(station)
      expect(subject.fare).to eq(Oystercard::PENALTY_FARE)
    end
    it 'calculates penalty fare if user forgets to touch_out' do
      subject.enter_station(station)
      subject.enter_station(station)
      expect(subject.fare).to eq(Oystercard::PENALTY_FARE)
    end
  end
end
