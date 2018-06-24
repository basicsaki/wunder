require "wunder_helper"

RSpec.describe Checkout do
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:product) { Product.new(product_code, name, 100) }
  let(:rules) { PromotionalRulesCollection.new }
  let(:rul1) { Promotional::Rule::QuantityPrice.new(1, 10) }
  let(:labl1) { "Flat_rate discount on prices" }
  let(:promotion_rule) { PromotionalRule.new(labl1, "percentage", true, rul1) }

  let(:checkout) { described_class.new(rules) }

  before do
    # promotional rules
    rules.push(promotion_rule)
    checkout.scan(product)
  end

  describe "#initialize" do
    it "contains a new basket and a promotional rules collection" do
      expect(checkout).to have_attributes(
        basket: checkout.basket,
        promotional_rules: checkout.promotional_rules
      )
    end
  end

  describe "#scan" do
    context "when a new product is scaned" do
      it "adds a new item in the checkout basket" do
        checkout.scan(product)
        products = checkout.basket.items.map(&:product)
        expect(products).to include(product)
      end
    end

    context "when an product already in the basket is scaned" do
      it "increases the quantity of the product in the basket" do
        checkout.scan(product)

        item = checkout.basket.items.find_product(product.product_code)
        expect(item.quantity).to eq(2)
      end
    end
  end

  describe "#remove_scan" do
    context "when an item quantity is more than 1 in the basket" do
      it "decreses the quantity of the item" do
        checkout.scan(product)

        checkout.remove_scan(product)

        item = checkout.basket.items.find_product(product.product_code)
        expect(item.quantity).to eq(1)
      end
    end

    context "when an item quantity = 1" do
      it "deletes the item from the basket" do
        checkout.remove_scan(product)

        item = checkout.basket.items.find_product(product.product_code)
        expect(item).to be_nil
      end
    end
  end

  describe "#total" do
    it "is instance of bigdecimal" do
      expect(checkout.total).to be_an_instance_of(BigDecimal)
    end

    context "when a percentage discount is applied" do
      it "calculates the basket total after discounts" do
        expect(checkout.total).to eq(BigDecimal(90))
      end

      it "calculates the basket total if scaned more than once" do
        checkout.scan(product)
        expect(checkout.total).to eq(BigDecimal(180))
      end
    end

    context "when a flat rate discount is applied" do
      let(:promotion_rule) do
        PromotionalRule.new(labl1, "flat_rate", true, rul1)
      end

      it "calculates the basket total after discounts" do
        expect(checkout.total).to eq(BigDecimal(10))
      end

      it "calculates the basket total after discounts if scaned > 1" do
        checkout.scan(product)
        expect(checkout.total).to eq(BigDecimal(20))
      end
    end

    context "when a flat rate discount is applied on the basket" do
      let(:promotion_rule) do
        PromotionalRule.new(labl1, "flat_rate", false, rul1)
      end

      it "calculates the basket total after discounts" do
        checkout.scan(product)
        expect(checkout.total).to eq(BigDecimal(200))
      end
    end

    context "when a flat rate discount is applied on the basket" do
      let(:promotion_rule) do
        PromotionalRule.new(labl1, "percentage", false, rul1)
      end

      it "when a percentage is applied on the basket" do
        checkout.scan(product)
        expect(checkout.total).to eq(BigDecimal(180))
      end
    end
  end
end
