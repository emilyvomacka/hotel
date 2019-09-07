class Room
  attr_reader :room_num 
  attr_accessor :reservations, :blocks
  
  def initialize(room_num)
    @room_num = room_num
    @reservations = []
    @blocks = []
  end
end