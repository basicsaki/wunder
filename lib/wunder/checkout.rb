require_relative "./basket.rb"
require_relative "./adjustment.rb"

class Checkout
  attr_accessor :basket, :promotional_rules

  def initialize(promotional_rules)
    @basket = Basket.new
    @promotional_rules = promotional_rules
  end

  def scan(product)
    basket.add_item(product)
  end

  def remove_scan(product)
    basket.remove_item(product)
  end

  def total    
    total_price_of_items_after_adjustments = BigDecimal(0)

    adjustment = Adjustment.new(basket, promotional_rules)
    adjustment.calculate_total
  end
end
