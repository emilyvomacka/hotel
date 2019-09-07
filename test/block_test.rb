require_relative 'test_helper'

describe "Block class" do
  describe "Block instantiation" do
    before do
      @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
      @block = Block.new(@date_range, name, 1, 100)
    end
    
    it "is an instance of Block" do
      expect(@block).must_be_kind_of Block
    end
    
    it "will raise an argument error in response to invalid date input" do 
      expect {Block.new(2019, 7, 4, 2019, 7, 1)}.must_raise ArgumentError
    end 
    
    it "can calculate total cost" do 
      expect(@block.total_cost).must_equal 300
    end 
    
  end 
end 