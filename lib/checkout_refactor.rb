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
        # Check for multibuy offer on item 
      if multibuy_offers[item] 
        # Calculate free items with Math.floor logic 
        amount_free = count / (multibuy_offers[item][0] + multibuy_offers[item][1]).floor
        # Check for restrictions and if they apply to the amount purchased 
        if multibuy_offers[item][2] > 0 && multibuy_offers[item][2] < count_free
            # Recalculate the amount free to the restricted amount 
            amount_free = multibuy_offers[item][2]
        end
        # subtracts the free items from the amount purchased and add to total
        total += prices.fetch(item) * (count - amount_free)
        # check for percentage discounts on item
      elsif percentage_discounts[item]
        # check for percentage discounts restricitons on item
        if percentage_discounts[item][1] > 0
            # calculate the amount of items allowed at discount price
            # if restrictions is less than puchase, amount_discounted will equal restricted value.
            amount_discounted = count < percentage_discounts[item][1] ? count : percentage_discounts[item][1]
            # add discounted items to total 
            total += prices.fetch(item) * percentage_discounts[item][0] * amount_discounted
            # add remainiing items over retrictions to total 
            total += prices.fetch(item) * (count - amount_discounted)
        else
        # apply percentage discounts by multiplying the price by the perc and count.
        total += prices.fetch(item) * percentage_discounts[item][0] * count
        end
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
