require_relative "../../promotional_rule.rb"

class Promotional::Rule::Product < PromotionalRule
  attr_reader :minimum_quantity, :maximum_quantity, :item_keywords

  def initialize(minimum_quantity, maximum_quantity)
    super
    @minimum_quantity = minimum_quantity
    @maximum_quantity = maximum_quantity

    validate
  end

  def validate
    super

    unless minimum_quantity.blank?
      should_be_a_number(minimum_quantity)
      should_not_be_less_than(minimum_quantity, 0)
    end

    unless maximum_quantity.blank? && minimum_quantity.blank?
      should_be_a_number(minimum_quantity)
      should_not_be_less_than(minimum_quantity, minimum_quantity)
    end
  end

  def eligible?(item, _quantity)
    true if (item.name.split(" ") & item_keywords) != []
    true if item.quantity > minimum_quantity
  end
end
