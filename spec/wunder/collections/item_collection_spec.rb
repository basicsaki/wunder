require "wunder_helper"

RSpec.describe ItemCollection do
  let(:items) { described_class.new }

  before do
    (0..3).each do |n|
      price = Faker::Commerce.price
      product = Product.new(n, Faker::GameOfThrones.character, price)
      items.push(BasketItem.new(product))
    end
  end

  describe "#find_product" do
    context "when product is in the collection" do
      it "fetches the product" do
        expect(items.find_product(0)).not_to be_nil
      end
      it "fetches the product with the same id" do
        expect(items.find_product(0).product.product_code).to eq(0)
      end
    end

    context "when the product is not present in the collection" do
      it "returns nil" do
        expect(items.find_product(10)).to be_nil
      end
    end
  end
end
