require_relative 'test_helper'

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @res = Reservation.new(2019, 7, 6, 2019, 7, 9)
    end
    
    it "is an instance of Reservation" do
      expect(@res).must_be_kind_of Reservation
    end
    
    it "assigns a room" do 
      expect(@res.room_num).must_be_kind_of Integer
    end 
    
    it "can calculate total cost" do 
      expect(@res.total_cost).must_equal 600
    end 
  end 
end 