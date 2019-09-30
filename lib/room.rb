class Room
  attr_reader :room_num 
  attr_accessor :reservations, :blocks
  
  def initialize(room_num)
    @room_num = room_num
    @reservations = []
    @blocks = []
  end
  
  def is_available(req_range)
    reservations.all? {|res| res.date_range.range.grep(req_range.range).length == 0 } && blocks.all? {|block| block.date_range.range.grep(req_range.range).length == 0 }    
  end     
end