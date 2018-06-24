require "wunder_helper"

RSpec.describe Promotional::Rule::BasketRule do
  let(:value) { BigDecimal(10) }
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:product) { Product.new(product_code, name, 100) }
  let(:basket) { Basket.new }

  let(:basket_rule) { described_class.new(value, false) }

  before do
    # promotional rules
    basket.add_item(product)
  end

  describe "#initialize" do
    context "when a new rule is created" do
      it "captures min value and quantity" do
        expect(basket_rule).to have_attributes(value: value)
      end
    end

    context "when a new rule is created with improper value" do
      let(:value) { nil }

      it "raises a runtime error" do
        expect { basket_rule }.to raise_error(RuntimeError)
      end
    end

    context "when a new rule is created with 0 value" do
      let(:value) { 0 }

      it "raises a runtime error" do
        expect { basket_rule }.to raise_error(RuntimeError)
      end
    end

    context "when validations are set to false  " do
      let(:value) { nil }
      let(:basket_rule) { described_class.new(value, true) }

      it "does not validate" do
        expect(basket_rule).to be_truthy
      end
    end
  end

  describe "#adjustable?" do
    context "when basket is eligible for the discount" do
      it "returns true" do
        expect(basket_rule).to be_adjustable(100)
      end
    end
    context "when product is not eligible for the discount" do
      let(:value) { 200 }

      it "returns false" do
        expect(basket_rule.adjustable?(100)).to eq(false)
      end
    end
  end

  describe "#calculate_total_discounted_price" do
    context "when discount type is percentage" do
      it "calculates the discounted price of the product" do
        price = basket_rule.calculate_total_discounted_price(100,
                                                             "percentage")
        expect(price).to eq(90)
      end
    end

    context "when discount type is flat rate" do
      it "calculates the discounted price of the product" do
        price = basket_rule.calculate_total_discounted_price(100, "flat_rate")
        expect(price).to eq(100)
      end
    end
  end

  describe "#calculate_total_discounted_price" do
    context "when discount type is percentage" do
      it "calculates the discounted price of the the basket" do
        price = basket_rule.calculate_total_discounted_price(100,
                                                             "percentage")
        expect(price).to eq(90)
      end
    end

    context "when discount type is flat rate" do
      it "calculates the discounted price of the product" do
        price = basket_rule.calculate_total_discounted_price(90,
                                                             "flat_rate")

        expect(price).to eq(90)
      end
    end
  end
end
