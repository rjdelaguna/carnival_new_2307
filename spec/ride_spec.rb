require 'spec_helper'

RSpec.describe Ride do
  before (:each) do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe "#initialize" do
    it 'creates a new instace of the ride class' do

      expect(@ride1).to be_a Ride
      expect(@ride2).to be_a Ride
      expect(@ride3).to be_a Ride
    end

    it 'has readable attributes' do

      expect(@ride1.name).to eq("Carousel")
      expect(@ride1.min_height).to eq(24)
      expect(@ride1.admission_fee).to eq(1)
      expect(@ride1.excitement).to eq(:gentle)
      expect(@ride2.name).to eq("Ferris Wheel")
      expect(@ride2.min_height).to eq(36)
      expect(@ride2.admission_fee).to eq(5)
      expect(@ride2.excitement).to eq(:gentle)
      expect(@ride3.name).to eq("Roller Coaster")
      expect(@ride3.min_height).to eq(54)
      expect(@ride3.admission_fee).to eq(2)
      expect(@ride3.excitement).to eq(:thrilling)
    end

    it "begins with no revenue" do

      expect(@ride1.total_revenue).to eq(0)
      expect(@ride2.total_revenue).to eq(0)
      expect(@ride3.total_revenue).to eq(0)
    end
  end
  
  describe "#board_rider" do
    it 'adds riders to the rider log' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
    
      expect(@ride1.rider_log).to eq({@visitor1 => 1, @visitor2 => 1})
    end
  
    it 'knows how many times a visitor has gone on the ride' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    
      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end
  
    it 'deducts the cost of the ride from the visitors spending money' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    
      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end
  end
  
  describe "#total_revenue" do
    it 'can calculate how much money the ride has earned' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.total_revenue).to eq(3)
    end
  end

  describe "#check_qualifiers" do
    it 'knows if a visitor is eligible to baord' do

      expect(@ride3.check_qualifiers(@visitor2)).to eq(false)
      expect(@ride1.check_qualifiers(@visitor2)).to eq(true)

      @ride1.board_rider(@visitor2)
      expect(@ride2.check_qualifiers(@visitor2)).to eq(false)
    end
  end

  describe "#board_rider qualifiers" do
    it 'will not board visitors who are not tall enough, match preference, or have enough money' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      @ride2.board_rider(@visitor2)
      
      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
      expect(@visitor3.spending_money).to eq(13)
      expect(@ride2.rider_log).to eq({})
      expect(@ride3.rider_log).to eq({@visitor3 => 1})
      expect(@ride3.total_revenue).to eq(2)
    end
  end
end



