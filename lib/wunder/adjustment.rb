class Adjustment
  attr_reader :basket, :promotional_rules

  def initialize(basket, promotional_rules)
    @basket = basket
    @promotional_rules = promotional_rules
  end

  def calculate_total
    total_basket_amount = apply_item_discounts
    apply_basket_discounts(total_basket_amount)
  end

  private

  def apply_item_discounts
    binding.pry
    adjusted_total = BigDecimal(0)
    product_promotional_rules = promotional_rules.select { |promotional_rule| promotional_rule.on_item == true }

    
    product_promotional_rules.each do |ppr|
      ppr.select{|ppr| }
    end

    basket.items.each do |product|
      eligible_promotional_rules = product.eligible_promotional_rules(product_promotional_rules)
      if product_promotional_rules.empty?
        adjusted_total += product.price
      else
        price_after_adjustments = product.apply_promotional_rules(product_promotional_rules)
        adjusted_total += price_after_adjustments
      end
    end

    adjusted_total
  end

  def apply_basket_discounts(items_total)
    basket_promotional_rules = promotional_rules.select { |promotional_rule| promotional_rule.on_item == false }
    adjusted_total = if basket_promotional_rules.empty?
                       items_total
                     else
                       basket.calculate_sum_after_adjustments(promotional_rules)
                     end

    adjusted_total
  end
end
