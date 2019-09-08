require_relative 'test_helper'

describe "Block class" do
  describe "Block instantiation" do
    before do
      @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
      @block = Block.new(@date_range, "name", 1, 100)
    end
    
    it "is an instance of Block" do
      expect(@block).must_be_kind_of Block
    end 
  end 
  
  describe "total cost" do
    before do
      @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
      @block = Block.new(@date_range, "name", 1, 100)
    end 
    
    it "can calculate total cost" do 
      expect(@block.total_cost).must_equal 300
    end 
  end 
  
  # describe "available_rooms" do
  #   before do
  #     @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
  #     @block = Block.new(@date_range, "name", 1, 100)
  #   end 
  
  #   it "can return a list of available rooms" do 
  #     expect(@block..length).must_equal @block.room_quantity
  #   end 
  
end 