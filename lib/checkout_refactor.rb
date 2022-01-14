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

    def total(multibuy_offers={}, percentage_discounts={})
        puts multibuy_offers
        puts percentage_discounts
    end
    private

    def basket
      @basket ||= Array.new
    end
end