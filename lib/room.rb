class Room
  attr_reader :room_num 
  attr_accessor :reservations
  
  def initialize(room_num)
    @room_num = room_num
    @reservations = []
  end
end