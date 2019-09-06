require_relative 'room'

class Hotel
  attr_reader :rooms
  def initialize
    @rooms = []
    20.times do |i|
      @rooms << Room.new(i + 1)
    end
  end
  
  def list_rooms
    @rooms.each do |curr_room|
      puts "Room Number #{curr_room.room_num}"
    end 
  end 
  
  # availability logic I'm not using yet.
  # def available_rooms(req_start_date, req_end_date = nil)
  #   @rooms.each do |room|
  #     room.reservations.each do |reservation|
  #       if req_start_date >= reservation.start_date && req_end_date <= reservation.end_date
  #       end 
  #     end
  #   end 
  # end 
end 