require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys, :log
  DEFAULT_BALANCE = 0
  LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @journeys = []
  end

  def top_up(cash)
    fail "Reached max limit of #{LIMIT}!" if LIMIT < (@balance + cash)
    @balance += cash
  end

  def touch_in(station, journey = Journey.new)
    fail "Insufficient balance!" if @balance < MINIMUM_BALANCE
    #@entry_station = station
    #@journey = @log[:touch_in]
    #@journey = journey
    journey.in_station(station)
    @log = journey
  end

  def touch_out(station)
    @balance -= MINIMUM_BALANCE
    #@entry_station = nil
    #@exit_station = station
    @log.out_station(station)
    @journeys << @log
  end

  def in_journey?
    true unless @entry_station == nil
  end

private
  def deduct(journey)
    @balance -= journey
  end
end
