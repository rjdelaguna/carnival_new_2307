class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :rider_log

  def initialize(info)
    @name = info[:name]
    @min_height = info[:min_height]
    @admission_fee = info[:admission_fee]
    @excitement = info[:excitement]
    @rider_log = Hash.new(0)
  end

  def board_rider(rider)
    if check_qualifiers(rider)
      if @rider_log[rider] == 0
        @rider_log[rider] = 1
      else
        @rider_log[rider] += 1
      end
      rider.charge_admission(@admission_fee)
    end
  end

  def check_qualifiers(visitor)
    visitor.preferences.include?(@excitement) &&
    visitor.height >= @min_height &&
    visitor.spending_money >= @admission_fee
  end

  def total_revenue
    @rider_log.values.sum * @admission_fee
  end
end