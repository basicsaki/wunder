require "wunder_helper"

RSpec.describe BasketItem do
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:price) { Faker::Commerce.price }
  let(:product) { Product.new(product_code, name, price) }
  let(:basket_item) { described_class.new(product) }

  describe "#initialize" do
    context "when a new basket item is created" do
      it "has attributes of a product and a quantity" do
        expect(basket_item).to have_attributes(product: product, quantity: 1)
      end

      it "sets the quantity of the basket item to 1" do
        expect(basket_item.quantity).to eq(1)
      end
    end
  end

  describe "#increment_item_quantity" do
    it "increses the item quantity by 1" do
      expect(basket_item.increment_item_quantity).to eq(2)
    end
  end

  describe "#decrement_item_quantity" do
    it "decreases the item quantity by 1" do
      basket_item.increment_item_quantity
      basket_item.increment_item_quantity
      expect(basket_item.decrement_item_quantity).to eq(2)
    end
  end
end
