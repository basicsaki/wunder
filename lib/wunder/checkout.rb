require_relative "./basket.rb"
require_relative "./adjustment.rb"

class Checkout
  attr_accessor :basket, :promotional_rules, :adjustment

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
    @adjustment = Adjustment.new(basket, promotional_rules)
    @adjustment.calculate_total
  end

  def applied_promotional_rules
    adjustment.eligible_promotional_rules if adjustment
  end
end
