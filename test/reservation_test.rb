require_relative 'test_helper'

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
      @res = Reservation.new(@date_range)
    end
    
    it "is an instance of Reservation" do
      expect(@res).must_be_kind_of Reservation
    end
    
    it "can calculate total cost" do 
      expect(@res.total_cost).must_equal 600
    end 
    
  end 
end 