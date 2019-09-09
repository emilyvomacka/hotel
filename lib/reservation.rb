class Reservation
  attr_reader :date_range, :block_name
  attr_accessor :room_num
  
  def initialize(res_range, block_name = nil)
    @date_range = res_range
    @block_name = block_name
  end
  
  def total_cost 
    return 200 * (date_range.end_date - date_range.start_date)
  end 
end