require "wunder_helper"

RSpec.describe Adjustment do
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:product) { Product.new(product_code, name, 100) }
  let(:rules) { PromotionalRulesCollection.new }
  let(:rul1) { Promotional::Rule::ItemQuantityPriceRule.new(1, 10) }
  let(:rul2) { Promotional::Rule::BasketRule.new(1, 10) }
  let(:labl1) { "Flat_rate discount on prices" }
  let(:promotion_rule) { PromotionalRule.new(labl1, "percentage", true, rul1) }
  let(:basket) { Basket.new }

  let(:adjustment) { described_class.new(basket, rules) }

  before do
    # promotional rules
    basket.add_item(product)
    rules.push(promotion_rule)
  end

  describe "#apply_item_discounts" do
    it "calculates the total discounted amount on all the basket items" do
      adjusted_total = adjustment.send(:apply_item_discounts)
      expect(adjusted_total).to eq(BigDecimal(90))
    end
  end

  describe "#apply_basket_discounts" do
    let(:promotion_rule) do
      PromotionalRule.new(labl1, "percentage", false, rul1)
    end

    it "calculates discount on basket" do
      basket.add_item(product)

      adjusted_total = adjustment.send(:apply_basket_discounts, 100)
      expect(adjusted_total).to eq(100)
    end
  end

  describe "#compute_item_discounted_price" do
    context "when product promotional rules is empty" do
      it "returns nil" do
        adjusted_total = adjustment.send(
          :compute_item_discounted_price, basket.items.first
        )
        expect(adjusted_total).to eq(nil)
      end
    end

    context "when product promotional rules is applied" do
      it "returns the calculated price" do
        [promotion_rule].each do |promotional_rule|
          price = promotional_rule.calculate_total(basket.items.first)
          basket.items.first.product.price = price unless price.nil?
        end

        expect(basket.items.first.product.price).to eq(BigDecimal(90))
      end
    end
  end

  describe "#eligible_product_promo_discounts" do
    context "when promotional rules are applied on the products" do
      it "returns the product promotional rules" do
        promos = adjustment.send(
          :eligible_product_promo_discounts, basket.items.first
        )
        expect(promos.first).to eq(promotion_rule)
      end
    end

    context "when promotional rules do not qualify for the product" do
      let(:promotion_rule) do
        PromotionalRule.new(labl1, "percentage", false, rul1)
      end

      it "returns nil" do
        promos = adjustment.send(
          :eligible_product_promo_discounts, basket.items.first
        )
        expect(promos.first).to eq(nil)
      end
    end
  end

  describe "#eligible_basket_promotional_discounts" do
    context "when basket promotional rules are not applied for the basket" do
      it "returns nil" do
        promos = adjustment.send(:eligible_basket_promotional_discounts, 10)
        expect(promos.first).to eq(nil)
      end
    end

    context "when basket promotional rules are applied" do
      let(:promotion_rule) do
        PromotionalRule.new(labl1, "percentage", false, rul2)
      end

      it "returns nil" do
        promos = adjustment.send(:eligible_basket_promotional_discounts, 100)
        expect(promos.first).to eq(promotion_rule)
      end
    end
  end
end
