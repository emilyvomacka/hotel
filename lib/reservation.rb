require 'date'
require_relative 'daterange'

class Reservation
  attr_reader :date_range
  attr_accessor :room_num
  
  def initialize(start_year, start_month, start_day, end_year, end_month, end_day)
    @date_range = DateRange.new(start_year, start_month, start_day, end_year, end_month, end_day)
  end
  
  def total_cost 
    return 200 * (date_range.end_date - date_range.start_date)
  end 
end