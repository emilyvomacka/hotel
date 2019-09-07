require_relative 'room'
require_relative 'reservation'
require_relative 'daterange'

class Hotel
  attr_reader :rooms
  def initialize(rooms)
    @rooms = []
    rooms.times do |i|
      @rooms << Room.new(i + 1)
    end
  end
  
  def list_rooms
    @rooms.each do |curr_room|
      puts "Room Number #{curr_room.room_num}"
    end 
  end 
  
  # future method for when rooms must be assigned according to availability 
  # def assign_room(start_date, end_date)
  #potential_drivers =  @drivers.select { |driver| driver.status == :AVAILABLE && driver.trips.none? { |trip| trip.end_time == nil }  } 
  
  def make_reservation(start_year, start_month, start_day, end_year, end_month, end_day)
    new_reservation = Reservation.new(start_year, start_month, start_day, end_year, end_month, end_day)
    potential_rooms = available_rooms(start_year, start_month, start_day, end_year, end_month, end_day)
    if potential_rooms.length == 0
      raise ArgumentError, "No vacancy :/"
    end 
    new_reservation.room_num = potential_rooms.sample.room_num.to_i
    @rooms[new_reservation.room_num - 1].reservations << new_reservation 
    return new_reservation
  end 
  
  #shows which rooms are available on a given day
  def available_rooms(start_year, start_month, start_day, end_year, end_month, end_day)
    req_range = DateRange.new(start_year, start_month, start_day, end_year, end_month, end_day)
    return @rooms.select { |room| room.reservations.none? { |res| res.date_range.range.grep(req_range) } }
  end 
  
  #returns all reservations for a given date
  def reservations_by_date(year, month, day)
    requested_date = Date.new(year, month, day)
    reservations_by_date = []
    @rooms.each do |room| 
      if valid_date_res = room.reservations.find {|res|res.date_range.range.include?(requested_date)}
        reservations_by_date << valid_date_res
      end 
    end 
    return reservations_by_date
  end 
end 