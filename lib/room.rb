class Room
  attr_reader :room_num
  
  def initialize(room_num)
    @room_num = room_num
    @reserved_dates = []
  end
end