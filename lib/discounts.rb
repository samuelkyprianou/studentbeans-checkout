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

class Multibuy_offers < Discounts

  # Creation of multibuy offer takes the item, the amount needed to hit the offer and the number of free items
  # e.g (:mango, 3, 1)
  def add_multibuy_offer(item, buy, free)
    offer = { item => [buy, free] }
    self.create_offer(offer)
  end
end

class Percentage_discounts < Discounts

    # Creation of percentage discount takes the item and the value of percentage to apply
    # 50% off bananas = (:bananas, 50)
  def add_percentage_discount(item, value)
    offer = { item => [value / 100.0] }
    self.create_offer(offer)
  end
end
