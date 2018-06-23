require "wunder_helper"

RSpec.describe ProductCollection do
  let(:collection) { described_class.new }

  before do
    (0..3).each do |n|
      price = Faker::Commerce.price
      collection << Product.new(n, Faker::GameOfThrones.character, price)
    end
  end

  describe "#find_by_product_code" do
    context "when product is in the collection" do
      it "fetches the product" do
        expect(collection.find_by_product_code(0)).not_to be_nil
      end
      it "fetches the product with the same id" do
        expect(collection.find_by_product_code(0).product_code).to eq(0)
      end
    end

    context "when the product is not present in the collection" do
      it "returns nil" do
        expect(collection.find_by_product_code(10)).to be_nil
      end
    end
  end

  describe "#validate_product_code_is_uniq(code)" do
    context "when a product with a similar code exists" do
      it "raises DuplicateProductCodeError" do
        p = "DuplicateProductCodeError"
        expect { collection.validate_product_code_is_uniq(0) }.to raise_error(p)
      end
    end

    context "when a new product is added" do
      it "returns true" do
        expect(collection.validate_product_code_is_uniq(10)).to be_truthy
      end
    end
  end
end
