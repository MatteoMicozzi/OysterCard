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
    penalty? ? Oystercard::PENALTY_FARE : Oystercard::MINIMUM_BALANCE
  end
  
  def penalty?
    true if @in_station == nil || @out_station == nil
  end
end
