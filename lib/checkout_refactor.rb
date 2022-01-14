# Refactored version of checkout class to dynamically read and apply discount for DB
class Checkout_refactor
  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total(multibuy_offers = {}, percentage_discounts = {})
    total = 0
    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
        # check for multibuy offer on item 
      if multibuy_offers[item] != nil
        # apply multibuy offer by using Math.floor logic and add to total
        total += prices.fetch(item) * (count - (count / (multibuy_offers[item][0] + multibuy_offers[item][1])).floor)
        # check for percentage discounts on item
      elsif percentage_discounts[item]
        # apply percentage discounts by using multiplying the price by the perc and count.
        total += prices.fetch(item) * percentage_discounts[item][0] * count
      else
        # add remaining items to the total
        total += prices.fetch(item) * count
      end
    end
    total
  end

  private

  def basket
    @basket ||= Array.new
  end
end
