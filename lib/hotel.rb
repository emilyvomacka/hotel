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
    res_range = DateRange.new(start_year, start_month, start_day, end_year, end_month, end_day)
    new_reservation = Reservation.new(res_range)
    potential_rooms = available_rooms(res_range)
    if potential_rooms.length == 0
      raise ArgumentError, "No vacancy"
    end 
    new_reservation.room_num = potential_rooms.sample.room_num.to_i
    @rooms[new_reservation.room_num - 1].reservations << new_reservation 
    return new_reservation
  end 
  
  def make_block(start_year, start_month, start_day, end_year, end_month, end_day, block_name, room_quantity, cost)
    block_range = DateRange.new(start_year, start_month, start_day, end_year, end_month, end_day)
    block = Block.new(block_range, block_name, room_quantity, cost)
    potential_rooms = available_rooms(block_range)
    if potential_rooms.length < room_quantity
      raise ArgumentError, "The hotel does not have a sufficient number of empty rooms to book this block."
    end 
    block_rooms = potential_rooms.sample(room_quantity)
    block_rooms.each do |block_room|
      block.room_nums << block_room.room_num
      @rooms[block_room.room_num - 1].blocks << block
    end 
    return block
  end 
  
  #shows which rooms are available on a given day, require date_range
  def available_rooms(req_range)
    return @rooms.select { |room| 
      room.reservations.all? {|res| res.date_range.range.grep(req_range.range).length == 0 } && room.blocks.all? {|block| block.date_range.range.grep(req_range.range).length == 0 }
    }
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
