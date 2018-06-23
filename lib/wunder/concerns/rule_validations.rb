module RuleValidations
  DISCOUNT_TYPES = %w[percentage flat_rate].freeze

  def should_be_present(_name, attribute)
    raise "#{attribute} Should be present" if attribute == "" || attribute.nil?
  end

  def check_discount_type(discount_type)
    raise "Discount type can only be a 'percentage' or 'flat_rate'" if DISCOUNT_TYPES.include?(discount_type) == false
  end

  def either_should_be_present(name, attribute_1, attribute_2)
    raise "atleast fill out #{name}" if attribute_1.empty? && attribute_2.empty?
  end

  def atleast_one_should_be_present(name, attribute_1, attribute_2)
    raise "either fill out #{name}" if attribute_1.empty? == false && attribute_2.empty? == false
  end

  def should_be_a_number(_name, attribute)
    raise "#{attribute} should be a number" if attribute.is_a?(Numeric) == false
  end

  def should_be_less_than(name, attribute, number)
    raise "#{name} should be greater than #{number}" if attribute < number
  end

  def should_be_a_boolean(name, attribute)
    raise "#{name} should be a boolean" if boolean?(attribute) == false
  end

  def boolean?(attribute)
    ["true", "false", true, false].include? attribute
  end
end
