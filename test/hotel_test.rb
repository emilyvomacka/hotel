require_relative 'test_helper'

describe "Hotel class" do
  describe "Hotel instantiation" do
    
    before do
      @hotel = Hotel.new
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end
    
    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel
    end
    
    it "has a room array of length 20" do
      expect(@hotel.rooms.length).must_equal 20
    end 
    
    it "can create a reservation" do 
      expect(@res).must_be_kind_of Reservation
    end 
    
    it "adds reservation to the reservation array for the correct room" do 
      expect(@hotel.rooms[@res.room_num - 1].reservations.length).must_equal 1
    end 
    
    it "shows a list of available rooms for a given date range" do 
      expect(@hotel.available_rooms(2019, 9, 2, 2019, 9, 3).length).must_equal 19
    end 
    
    it "returns a list of reservations for a given date" do 
      expect(@hotel.reservations_by_date(2019, 9, 2).length).must_equal 1
    end 
  end 
end 