# Discounts class to hold all offers
class Discounts
  attr_reader :discounts_db

  # default empty hash will be initialize on no value
  def initialize(hash = {})
    @discounts_db = hash
  end

    #write to discount DB with merging hash 
  def create_offer(offers)
    discounts_db.merge!(offers)
  end
end
