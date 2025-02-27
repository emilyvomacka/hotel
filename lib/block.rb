class Block
  attr_reader :date_range, :name, :room_quantity, :cost
  attr_accessor :room_nums 
  
  def initialize(block_range, block_name, room_quantity, cost)
    @date_range = block_range
    @name = block_name
    @room_quantity = room_quantity
    @room_nums = []
    @cost = cost 
  end 
  
  def total_cost 
    return @cost * (date_range.end_date - date_range.start_date)
  end 
  
  def unbooked_rooms_count
    return @room_nums.length 
  end 
end