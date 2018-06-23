class PromotionalRulesCollection < Array
  def find_promotional_rule(rule)
    each do |promotional_rule|
      @promotional_rule = promotional_rule if promotional_rule == rule
    end

    @promotional_rule
  end

  def validate_promotion_rule_is_uniq(promotional_rule)
    find_promotional_rule(promotional_rule).nil? ? true : (raise "DuplicatePromotionalRuleError")
  end
end
