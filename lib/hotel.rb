require_relative 'room'

class Hotel
  attr_reader :rooms
  def initialize(room_num)
    @rooms = []
    20.times do |i|
      @rooms << Room.new(i)
    end
  end
  
  def list_rooms
    rooms.each do 
      puts "Room Number #{room_num}"
    end 
  end 
end