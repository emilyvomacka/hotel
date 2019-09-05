require_relative 'test_helper'

describe "Hotel class" do
  describe "Hotel instantiation" do
    before do
      @hotel = Hotel.new(4)
    end
    
    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel
    end
    
    it "has a room array of length 20" do
      expect(@hotel.rooms.length).must_equal 20
    end 
  end 
end 