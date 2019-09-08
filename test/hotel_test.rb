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
  
  describe "make_block" do 
    before do 
      @hotel = Hotel.new(4)
      @block = @hotel.make_block(2019, 9, 1, 2019, 9, 5, "name", 1, 100)
    end 
    
    it "can create a block" do 
      expect(@block).must_be_kind_of Block
    end 
    
    it "correctly adds a block to the blocks array under the correct room when booking a single room" do 
      expect(@hotel.rooms[@block.room_nums[0] - 1].blocks.length).must_equal 1
    end 
    
    it "correctly adds a block to the blocks array under multiple rooms when blocking multiple rooms" do 
      block2 = @hotel.make_block(2019, 9, 1, 2019, 9, 5, "zora", 3, 100)
      @hotel.rooms.each do |room|
        if block2.room_nums.include?(room.room_num)
          expect(room.blocks[0]).must_equal block2 
        end 
      end 
    end 
    
    describe "make_block_reservation" do 
      before do 
        @hotel = Hotel.new(4)
        @block = @hotel.make_block(2019, 9, 1, 2019, 9, 5, "zadie", 3, 100)
        @blocked_room_nums = @block.room_nums.dup
        @block_res = @hotel.make_block_reservation(2019, 9, 1, 2019, 9, 5, "zadie")
      end 
      
      it "can create a reservation" do 
        expect(@block_res).must_be_kind_of Reservation
      end 
      
      it "adds reservation to the reservation array for a room included in the block" do 
        expect(@hotel.rooms[@block_res.room_num - 1].reservations.length).must_equal 1
        expect(@hotel.rooms[@block_res.room_num - 1].reservations[0]).must_equal @block_res
        expect(@blocked_room_nums).must_include @block_res.room_num
      end 
      
      it "returns an error if the user tries to book for different dates than the block specifies" do
        expect {@hotel.make_block_reservation(2019, 9, 1, 2019, 9, 3, "zadie")}.must_raise ArgumentError
      end 
      
      it "return an error if the user tries to book a block under a name not found in the blocks array" do
        expect {@hotel.make_block_reservation(2019, 9, 1, 2019, 9, 3, "nora")}.must_raise ArgumentError
      end 
      
      it "returns an error if the user tried to book a block containing a name and date range identical to a block already in the system" do 
        expect {@hotel.make_block(2019, 9, 1, 2019, 9, 5, "zadie", 1, 100)}.must_raise ArgumentError 
      end 
      
      it "returns an error if the user tries to book more rooms than the hotel has available" do 
        expect {@hotel.make_block(2019, 9, 1, 2019, 9, 5, "diff_name", 4, 100)}.must_raise ArgumentError
      end 
      
      it "adds block to the hotel's list of blocks" do
        expect(@hotel.blocks[0]).must_equal @block
      end 
    end 
    
    describe "available_rooms" do 
      before do 
        @hotel = Hotel.new(4)
        @res = @hotel.make_reservation(2019, 9, 1, 2019, 9, 5)
        @date_range = DateRange.new(2019, 9, 2, 2019, 9, 3)
      end 
      
      it "decreases list of available rooms for a date conflicting with a single reservation by 1" do 
        expect(@hotel.available_rooms(@date_range).length).must_equal 3
      end 
      
      it "does not list previously reserved room as available for a subsequent reservation" do
        available_room_nums = @hotel.available_rooms(@date_range).map do |room|
          room.room_num
        end 
        expect(available_room_nums).wont_include @res.room_num
      end 
      
      it "does not list previously blocked rooms as available for a subsequent reservation not within a block" do 
        @hotel.make_block(2019, 9, 1, 2019, 9, 5, "name", 2, 100)
        expect(@hotel.available_rooms(@date_range).length).must_equal 1
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
end 