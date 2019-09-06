require_relative 'test_helper'

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Room.new(4)
    end
    
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Room
    end
    
    it "can return cost, which equals 200" do 
      expect(@room.cost).must_equal 200
    end 
    
    it "can return room number" do 
      expect(@room.room_num).must_equal 4
    end 
  end 
end 