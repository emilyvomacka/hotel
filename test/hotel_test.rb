require_relative 'test_helper'

describe "Hotel class" do
  describe "Hotel instantiation" do
    before do
      @hotel = Hotel.new(4)
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end
    
    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel
    end
    
    it "has an array of rooms equalling the 'rooms' initialization parameter" do
      expect(@hotel.rooms.length).must_equal 4
    end 
  end 
  
  describe "make_reservation" do 
    before do 
      @hotel = Hotel.new(4)
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end 
    
    it "can create a reservation" do 
      expect(@res).must_be_kind_of Reservation
    end 
    
    it "adds reservation to the reservation array for the correct room" do 
      expect(@hotel.rooms[@res.room_num - 1].reservations.length).must_equal 1
    end 
    
    it "returns an error if the user tries to book when the hotel is full" do
      3.times do 
        @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
      end 
      expect {@hotel.make_reservation(2019, 9, 1, 2019, 9, 5)}.must_raise ArgumentError
    end 
  end 
  
  describe "make_reservation conflicting date edge cases" do 
    before do 
      @hotel = Hotel.new(1)
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end 
    
    it "will allow an adjacent previous booking" do
      expect(@hotel.make_reservation(2019, 8, 1, 2019, 9, 1)).must_be_kind_of Reservation
    end 
    
    it "will allow an adjacent subsequent booking" do
      expect(@hotel.make_reservation(2019, 9, 5, 2019, 9, 7)).must_be_kind_of Reservation
    end 
    
    it "will not allow a booking surrounding an existing reservation" do
      expect{@hotel.make_reservation(2019, 8, 1, 2019, 10, 1)}.must_raise ArgumentError
    end 
    
    it "will not allow a booking within an existing reservation" do 
      expect{@hotel.make_reservation(2019, 9, 2, 2019, 9, 3)}.must_raise ArgumentError
    end 
    
    it "will not allow a partially overlapping booking" do 
      expect{@hotel.make_reservation(2019, 8, 27, 2019, 9, 3)}.must_raise ArgumentError
    end 
  end 
  
  describe "available_rooms" do 
    before do 
      @hotel = Hotel.new(4)
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end 
    
    it "decreases list of available rooms for a date conflicting with a single reservation by 1" do 
      expect(@hotel.available_rooms(2019, 9, 2, 2019, 9, 3).length).must_equal 3
    end 
    
    it "does not list previously reserved room in list of available rooms" do
      available_room_nums = @hotel.available_rooms(2019, 9, 2, 2019, 9, 3).map do |room|
        room.room_num
      end 
      expect(available_room_nums).wont_include @res.room_num
    end 
  end 
  
  describe "reservations_by_date" do 
    before do 
      @hotel = Hotel.new(4)
      @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
    end 
    
    it "returns a list of reservations for a given date" do 
      expect(@hotel.reservations_by_date(2019, 9, 2).length).must_equal 1
    end 
  end 
end 