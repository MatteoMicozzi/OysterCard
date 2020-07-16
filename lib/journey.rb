class Journey
  attr_reader :in_station, :out_station
  def enter_station(station)
    @in_station = station
  end
  def exit_station(station)
    @out_station = station
  end
  def in_journey?
    true unless (@in_station == nil && @out_station != nil)
  end

  def fare
    if @in_station == nil || @out_station == nil
      Oystercard::PENALTY_FARE
    else
      Oystercard::MINIMUM_BALANCE
    end
  end
end
