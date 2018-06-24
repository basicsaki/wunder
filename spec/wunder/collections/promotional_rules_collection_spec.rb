require "wunder_helper"

RSpec.describe PromotionalRulesCollection do
  let(:rules) { described_class.new }
  let(:rul1) { Promotional::Rule::ItemQuantityPriceRule.new(1, 10) }
  let(:rul2) { Promotional::Rule::ItemQuantityPriceRule.new(1, 10) }
  let(:labl1) { "Flat_rate discount on prices" }
  let(:labl2) { "Percentage discount on prices" }
  let(:promotion_rule1) { PromotionalRule.new(labl1, "percentage", true, rul2) }
  let(:promotion_rule2) { PromotionalRule.new(labl2, "flat_rate", true, rul1) }
  let(:promotion_rule3) { PromotionalRule.new(labl2, "flat_rate", false, rul1) }

  before do
    # promotional rules
    rules.push(promotion_rule1)
    rules.push(promotion_rule2)
  end

  describe "#find_promotional_rule" do
    context "when rule is in the collection" do
      it "fetches the product" do
        rule = rules.find_promotional_rule(promotion_rule1)
        expect(rule).not_to be_nil
      end
      it "fetches the rule with the same label" do
        label = rules.find_promotional_rule(promotion_rule1).label
        expect(label).to eq(labl1)
      end
    end

    context "when rule is not present in the collection" do
      it "returns nil" do
        expect(rules.find_promotional_rule(promotion_rule3)).to be_nil
      end
    end
  end

  describe "#validate_product_code_is_uniq(code)" do
    context "when a product with a similar code exists" do
      it "raises DuplicateProductCodeError" do
        p = "DuplicatePromotionalRuleError"
        expect { rules.validate_promotion_rule_is_uniq(promotion_rule1) }
          .to raise_error(p)
      end
    end

    context "when a new rule is added" do
      it "returns true" do
        uniq = rules.validate_promotion_rule_is_uniq(promotion_rule3)
        expect(uniq).to be_truthy
      end
    end
  end
end
