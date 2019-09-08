require_relative 'test_helper'

describe "DateRange class" do
  describe "DateRange instantiation" do
    before do
      @date_range = DateRange.new(2019, 7, 6, 2019, 7, 9)
    end
    
    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of DateRange
    end 
    
    it "includes a start date" do
      expect(@date_range.start_date).must_be_kind_of Date
    end 
    
    it "includes an end date" do
      expect(@date_range.end_date).must_be_kind_of Date
    end
    
    it "does not include last day of range" do 
      expect(@date_range.range).wont_include @date_range.end_date
    end 
    
    it "raises an ArgumentError if end date is before start date" do
      expect{DateRange.new(2019, 7, 6, 2019, 7, 1)}.must_raise ArgumentError
    end 
  end 
end 