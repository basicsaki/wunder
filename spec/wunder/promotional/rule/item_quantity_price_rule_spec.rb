require "wunder_helper"

RSpec.describe Promotional::Rule::ItemQuantityPriceRule do
  let(:minimum_quantity) { 1 }
  let(:value) { BigDecimal(10) }
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:product) { Product.new(product_code, name, 100) }
  let(:basket) { Basket.new }

  let(:item_quantity_price_rule) do
    described_class.new(minimum_quantity, value, false)
  end

  before do
    # promotional rules
    basket.add_item(product)
  end

  describe "#initialize" do
    context "when a new rule is created" do
      it "captures min value and quantity" do
        expect(item_quantity_price_rule)
          .to have_attributes(minimum_quantity: minimum_quantity, value: value)
      end
    end

    context "when a new rule is created with minimum_quantity missing" do
      let(:minimum_quantity) { nil }

      it "raises a runtime error" do
        expect { item_quantity_price_rule }.to raise_error(RuntimeError)
      end
    end

    context "when a new rule is created with improper value" do
      let(:value) { nil }

      it "raises a runtime error" do
        expect { item_quantity_price_rule }.to raise_error(RuntimeError)
      end
    end

    context "when a new rule is created with improper minimum_quantity" do
      let(:minimum_quantity) { 0 }

      it "raises a runtime error" do
        expect { item_quantity_price_rule }.to raise_error(RuntimeError)
      end
    end

    context "when validations are set to false  " do
      let(:value) { nil }
      let(:item_quantity_price_rule) do
        described_class.new(minimum_quantity, value, true)
      end

      it "does not validate" do
        expect(item_quantity_price_rule).to be_truthy
      end
    end
  end

  describe "#eligible?" do
    context "when product is eligible for the discount" do
      it "returns true" do
        item = basket.items.first
        expect(item_quantity_price_rule).to be_eligible(item)
      end
    end
    context "when product is not eligible for the discount" do
      let(:minimum_quantity) { 2 }

      it "returns false" do
        item = basket.items.first
        expect(item_quantity_price_rule.eligible?(item)).to eq(false)
      end
    end
  end

  describe "#calculate_discounted_price" do
    context "when discount type is percentage" do
      it "calculates the discounted price of the product" do
        item = basket.items.first
        price = item_quantity_price_rule
                .calculate_discounted_price(item, "percentage")
        expect(price).to eq(90)
      end
    end

    context "when discount type is flat rate" do
      it "calculates the discounted price of the product" do
        item = basket.items.first
        price = item_quantity_price_rule
                .calculate_discounted_price(item, "flat_rate")
        expect(price).to eq(10)
      end
    end
  end

  describe "#calculate_total_discounted_price" do
    context "when discount type is percentage" do
      it "calculates the discounted price of the the basket" do
        price = item_quantity_price_rule
                .calculate_total_discounted_price(100, "percentage")
        expect(price).to eq(90)
      end
    end

    context "when discount type is flat rate" do
      it "calculates the discounted price of the product" do
        price = item_quantity_price_rule
                .calculate_total_discounted_price(90, "flat_rate")

        expect(price).to eq(90)
      end
    end
  end
end
