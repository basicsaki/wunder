class Adjustment
  attr_reader :basket, :promotional_rules
  attr_accessor :eligible_promotional_rules

  def initialize(basket, promotional_rules)
    @basket = basket
    @promotional_rules = promotional_rules
    @applied_promotional_rules = []
  end

  def calculate_total
    adjusted_total = apply_item_discounts
    apply_basket_discounts(adjusted_total)
  end

  def eligible_promotional_rules
    pr = (@basket_promotional_rules | @product_promotional_rules).map(&:label)
    pr.join(",")
  end

  private

  def apply_item_discounts
    adjusted_total = BigDecimal(0)

    basket.items.each do |basket_item|
      @product_promotional_rules = eligible_product_promotional_discounts(basket_item)

      unless @product_promotional_rules.empty?
        @product_promotional_rules.each do |promotional_rule|
          price = promotional_rule.calculate_total(basket_item)
          basket_item.product.price = price unless price.nil?
        end
      end

      adjusted_total += basket_item.product.price * basket_item.quantity.to_i
    end
    adjusted_total
  end

  def apply_basket_discounts(items_total)
    @basket_promotional_rules = eligible_basket_promotional_discounts

    unless @basket_promotional_rules.empty?
      basket_promotional_rules.each do |promotional_rule|
        total = promotional_rule.calculate_total(items_total)
        items_total = total
      end
    end

    items_total
  end

  def eligible_product_promotional_discounts(basket_item)
    promotional_rules.select do |promotional_rule|
      promotional_rule.on_item == true && promotional_rule.rule.eligible?(basket_item)
    end
  end

  def eligible_basket_promotional_discounts
    promotional_rules.select { |promotional_rule| promotional_rule.on_item == false }
  end
end
