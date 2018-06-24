require "wunder_helper"

RSpec.describe Product do
  let(:name) { Faker::GameOfThrones.character }
  let(:product_code) { 0o01 }
  let(:price) { Faker::Commerce.price }

  let(:product) { described_class.new(product_code, name, price) }

  describe "#validate" do
    context "when a product is valid" do
      it "raises parameter missing error " do
        expect(product.validate).to be_nil
      end
    end

    context "when product code is missing" do
      let(:product_code) { nil }

      it "raises parameter missing error " do
        expect { product.validate }.to raise_error("ProductParameterMissing")
      end
    end

    context "when name is missing" do
      let(:name) { nil }

      it "raises parameter missing error " do
        expect { product.validate }.to raise_error("ProductParameterMissing")
      end
    end

    context "when price is missing" do
      let(:price) { nil }

      it "raises parameter missing error " do
        expect { product.validate }.to raise_error("ProductParameterMissing")
      end
    end
  end
end
