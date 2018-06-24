require "wunder_helper"

RSpec.describe Basket do
  let(:basket) { described_class.new }
  let(:items) { basket.items }
  let(:product_code) { 0o01 }
  let(:price) { Faker::Commerce.price }

  let(:product) { Product.new(product_code, "fruit", price) }

  describe "#initialize" do
    context "when a new instance of basket is created" do
      it "has a ItemCollection attribute" do
        expect(basket).to have_attributes(items: ItemCollection.new)
      end

      it "creates an instance of item collection " do
        expect(basket.items).to be_an_instance_of(ItemCollection)
      end
    end
  end

  describe "#add_item" do
    before do
      basket.add_item(product)
    end
    context "when an item is not present in the basket" do
      it "adds a new item to basket" do
        expect(items.find_product(product_code).product).to eq(product)
      end

      it "places the quantity to 1" do
        expect(items.find_product(product_code).quantity).to eq(1)
      end
    end

    context "when an item is already present in the basket" do
      it "increases the quantity" do
        basket.add_item(product)
        expect(items.find_product(product_code).quantity).to eq(2)
      end
    end
  end

  describe "#remove_item" do
    before do
      basket.add_item(product)
    end

    context "when quantity of the item > 1" do
      it "decrements the quantity of the item in the basket" do
        basket.add_item(product)
        basket.remove_item(product)
        expect(items.find_product(product_code).quantity).to eq(1)
      end
    end

    context "when quantity of the item = 1" do
      it "deletes the item from the basket" do
        basket.remove_item(product)
        basket.remove_item(product)
        expect(items.find_product(product_code)).to be_nil
      end
    end
  end

  describe "#items_in_basket" do
    it "shows the names of the products in the basket with ids" do
      basket.add_item(product)

      expect(basket.items_in_basket).to eq("1 - fruit")
    end
  end
end
