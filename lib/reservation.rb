require 'date'
require_relative 'hotel'

class Reservation
  attr_reader :start_date, :end_date
  
  def initialize(start_year, start_month, start_day, end_year, end_month, end_day)
    @start_date = Date.new(start_year, start_month, start_day)
    @end_date = Date.new(end_year, end_month, end_day)
    @room_num = rand(1..20)
    if @end_date <= @start_date
      raise ArgumentError, "End date must be later than start date."
    end 
  end
  
  def total_cost 
    return 200 * (end_date - start_date)
  end 
end