require "wunder_helper"

RSpec.describe RuleValidations do
  let(:module_class) { Class.new { include RuleValidations } }
  let(:sample_object) { module_class.new }
  let(:discount_types) { %w[percentage flat_rate].freeze }

  describe "#should_be_present" do
    context "when attribute is present" do
      it "returns nil" do
        expect(sample_object.should_be_present("name", "value")).to be_nil
      end
    end
    context "when attribute is missing" do
      it "raises a runtime error" do
        expect { sample_object.should_be_present("name", "") }
          .to raise_error(RuntimeError)
      end
    end
  end

  describe "#check_discount_type" do
    context "when discount types are not in float rate or %" do
      let(:discount_type) { "" }

      it "raises an argument error" do
        discount_type_error = "Allowed values 'percentage' or 'flat_rate'"
        expect { sample_object.check_discount_type(discount_type) }
          .to raise_error(ArgumentError, discount_type_error)
      end
    end

    context "when no arguments are passed" do
      let(:discount_type) { nil }

      it "raises an argument error" do
        expect { sample_object.check_discount_type }
          .to raise_error(ArgumentError)
      end
    end

    context "when discount types are in flat rate or %" do
      let(:discount_type) { "percentage" }

      it "returns nil" do
        expect(sample_object.check_discount_type(discount_type)).to be_nil
      end
    end

    context "when discount types are in flat rate or %" do
      let(:discount_type) { "flat_rate" }

      it "returns nil" do
        expect(sample_object.check_discount_type(discount_type)).to be_nil
      end
    end
  end

  describe "#either_should_be_present" do
    context "when attributes are present" do
      it "returns nil" do
        expect(sample_object.either_should_be_present("nam", "value", "value2"))
          .to be_nil
      end
    end

    context "when either is missing" do
      it "raises a runtime error" do
        expect { sample_object.either_should_be_present("name", "", "") }
          .to raise_error(RuntimeError)
      end
    end

    context "when either is missing" do
      it "returns nil if attribute 1 is present" do
        expect(sample_object.either_should_be_present("name", "value", ""))
          .to be_nil
      end

      it "returns nil if attribute 2 is present" do
        expect(sample_object.either_should_be_present("name", "", "value2"))
          .to be_nil
      end
    end
  end

  describe "#should_be_a_number" do
    context "when attributes are present" do
      it "returns nil" do
        expect(sample_object.should_be_a_number("name", 123)).to be_nil
      end
    end

    context "when attribute is not a number" do
      it "raises a runtime error" do
        expect { sample_object.should_be_a_number("name", "string") }
          .to raise_error(RuntimeError)
      end
    end
  end

  describe "#should_be_less_than" do
    context "when attribute < number provided " do
      it "returns nil" do
        expect(sample_object.should_be_less_than("name", 20, 10)).to be_nil
      end
    end

    context "when attribute > number provided " do
      it "raises a runtime error" do
        expect { sample_object.should_be_less_than("name", 10, 20) }
          .to raise_error(RuntimeError)
      end
    end
  end

  describe "#should_be_a_boolean" do
    context "when attribute is a boolean " do
      it "returns nil" do
        expect(sample_object.should_be_a_boolean("name", true)).to be_nil
      end
    end

    context "when number is not a boolean " do
      it "raises a rumtime error" do
        expect { sample_object.should_be_a_boolean("name", "") }
          .to raise_error(RuntimeError)
      end
    end
  end

  describe "#boolean?" do
    context "when attribute is a boolean " do
      it "returns nil" do
        expect(sample_object).to be_boolean(true)
      end
    end

    context "when number is not a boolean " do
      it "raises a rumtime error" do
        expect(sample_object).not_to be_boolean("")
      end
    end
  end
end
