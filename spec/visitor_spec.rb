require 'spec_helper'

RSpec.describe Visitor do
  before (:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  describe "#initialize" do
    it 'creates a new instance of visitor' do

      expect(@visitor1).to be_a Visitor
      expect(@visitor2).to be_a Visitor
      expect(@visitor3).to be_a Visitor
    end

    it 'has readable attributes' do

      expect(@visitor1.name).to eq("Bruce")
      expect(@visitor1.height).to eq(54)
      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor1.preferences).to eq([])
      expect(@visitor2.name).to eq("Tucker")
      expect(@visitor2.height).to eq(36)
      expect(@visitor2.spending_money).to eq(5)
      expect(@visitor2.preferences).to eq([])
      expect(@visitor3.name).to eq("Penny")
      expect(@visitor3.height).to eq(64)
      expect(@visitor3.spending_money).to eq(15)
      expect(@visitor3.preferences).to eq([])
    end
  end

  describe "#add_preference" do
    it 'adds to the preference array' do
      @visitor1.add_preference(:gentle)
      @visitor1.add_preference(:thrilling)

      expect(@visitor1.preferences).to eq([:gentle, :thrilling])
    end
  end

  describe "#tall_enough" do
    it 'can tell if a visitor is tall enough for a height requirement' do

      expect(@visitor1.tall_enough?(54)).to eq(true)
      expect(@visitor2.tall_enough?(54)).to eq(false)
      expect(@visitor3.tall_enough?(54)).to eq(true)
      expect(@visitor1.tall_enough?(64)).to eq(false)
    end
  end

  describe "#charge_admission" do
    it 'deducts the cost from spending money' do

      expect(@visitor1.spending_money).to eq(10)
      
      @visitor1.charge_admission(2)
      
      expect(@visitor1.spending_money).to eq(8)
    end
  end
end











