require_relative 'test_helper'

describe "Hotel class" do
  describe "Hotel instantiation" do
    before do
      @hotel = Hotel.new
    end
    
    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel
    end
    
    it "has a room array of length 20" do
      expect(@hotel.rooms.length).must_equal 20
    end 
    
    # it "can list all rooms" do 
    #   expect(@hotel.list_rooms).must_equal "Room Number 1\nRoom Number 2\nRoom Number 3\nRoom Number 4\nRoom Number 5\nRoom Number 6\nRoom Number 7\nRoom Number 8\nRoom Number 9\nRoom Number 10\nRoom Number 11\nRoom Number 12\nRoom Number 13\nRoom Number 14\nRoom Number 15\nRoom Number 16\nRoom Number 17\nRoom Number 18\nRoom Number 19\nRoom Number 20\n" 
    # end 
  end 
end 