require 'spec_helper'

RSpec.describe Carnival do
  before (:each) do
    @carnival = Carnival.new("2 weeks")
  end

  describe "#initialize" do
    it 'creates a new instance of carnival class' do

      expect(@carnival).to be_a Carnival
    end

    it 'has readable attributes' do

      expect(@carnival.duration).to eq(14)
    end

    it 'starts with an empty array of rides' do

      expect(@carnival.rides).to eq([])
    end
  end

  desribe "#add_ride" do
    it 'adds ride class objects to the rides array' do
      @carnival.add_ride()
end
