class Adjustment
  attr_reader :basket, :promotional_rules

  def initialize(basket, promotional_rules)
    @basket = basket
    @promotional_rules = promotional_rules
    @product_promotional_rules = []
    @basket_promotional_rules = []
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
      @product_promotional_rules = eligible_product_promo_discounts(basket_item)
      compute_item_discounted_price(basket_item)
      adjusted_total += basket_item.product.price * basket_item.quantity
    end
    adjusted_total
  end

  def apply_basket_discounts(items_total)
    @basket_promotional_rules =
      eligible_basket_promotional_discounts(items_total)

    unless @basket_promotional_rules.empty?
      @basket_promotional_rules.each do |promotional_rule|
        items_total = promotional_rule.calculate_total(items_total)
      end
    end

    items_total
  end

  def compute_item_discounted_price(basket_item)
    return if @product_promotional_rules.empty?
    @product_promotional_rules.each do |promotional_rule|
      price = promotional_rule.calculate_total(basket_item)
      basket_item.product.price = price unless price.nil?
    end
  end

  def eligible_product_promo_discounts(basket_item)
    promotional_rules.select do |promo_rule|
      promo_rule.on_item == true && promo_rule.rule.eligible?(basket_item)
    end
  end

  def eligible_basket_promotional_discounts(total)
    promotional_rules.select do |promo_rule|
      promo_rule.on_item == false && promo_rule.rule.adjustable?(total)
    end
  end
end
