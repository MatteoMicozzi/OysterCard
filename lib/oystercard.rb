require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeys, :log
  DEFAULT_BALANCE = 0
  LIMIT = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

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
    @balance -= PENALTY_FARE if @log != nil
    journey.enter_station(station)
    @log = journey
  end

  def touch_out(station)
    @log = Journey.new if @log == nil

    @log.exit_station(station)
    deduct(@log.fare)
    @journeys << @log
  end

private
  def deduct(journey)
    @balance -= journey
  end
end
