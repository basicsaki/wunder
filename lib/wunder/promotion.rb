require_relative "./collections/promotional_rules_collection.rb"
require_relative "./promotional_rule.rb"

class Promotion
  attr_reader :name, :promotion_code

  attr_accessor :promotion_rules

  def initialize(name, promotion_code)
    @name = name
    @promotion_code = promotion_code
    @promotion_rules = PromotionalRulesCollection.new
  end

  def add_rule(promotion_rule)
    rule = promotion_rules.find_promotional_rule(promotion_rule)
    promotion_rules.push(promotion_rule) if rule.nil?
  end

  def remove_rule(promotion_rule)
    rule = promotion_rules.find_promotional_rule(promotion_rule)
    promotion_rules.delete(rule) unless rule.nil?
  end

  def add_rules_in_bulk(promotion_rules)
    promotion_rules.each do |promotion_rule|
      add_rule(promotion_rule)
    end
  end
end
