require_relative "./concerns/rule_validations.rb"

class PromotionalRule
  include RuleValidations

  attr_reader :label, :discount_type, :on_item, :rule

  def initialize(label, discount_type, on_item, rule, no_validate = false)
    @label = label
    @discount_type = discount_type
    @on_item = on_item
    @rule = rule

    validate if no_validate == false
  end

  def eligible?
    raise "Should be defined by the respective rule"
  end

  def adjustable?(_total)
    raise "Should be defined by the respective rule"
  end

  def validate
    should_be_present("label", label)
    check_discount_type(discount_type)
    should_be_a_boolean("PromotionaRule::OnItem", on_item)
    should_be_present("PromotionalRule::Rule", rule)
  end

  def calculate_discounted_price
    raise "Should be defined by the respective rule"
  end

  def calculate_total_discounted_price
    raise "Should be defined by the respective rule"
  end

  def calculate_total(arg)
    if on_item == true
      rule.calculate_discounted_price(arg, discount_type)
    else
      rule.calculate_total_discounted_price(arg, discount_type)
    end
  end
end
