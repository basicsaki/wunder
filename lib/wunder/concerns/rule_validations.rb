module RuleValidations
  DISCOUNT_TYPES = %w[percentage flat_rate].freeze

  def should_be_present(name, attr)
    raise "#{name}.capitalize should be present" if attr == "" || attr.nil?
  end

  def check_discount_type(discount_type)
    discount_type_error = "Allowed values 'percentage' or 'flat_rate'"
    raise ArgumentError, discount_type_error unless
    DISCOUNT_TYPES.include?(discount_type)
  end

  def either_should_be_present(name, attr1, attr2)
    raise "atleast fill out #{name}" if attr1.empty? && attr2.empty?
  end

  def should_be_a_number(name, attribute)
    raise "#{name} should be a number" if attribute.is_a?(Numeric) == false
  end

  def should_be_more_than(name, attribute, number)
    raise "#{name} should be >= #{number}" if attribute < number
  end

  def should_be_a_boolean(name, attribute)
    raise "#{name} should be a boolean" if boolean?(attribute) == false
  end

  def boolean?(attribute)
    ["true", "false", true, false].include? attribute
  end
end
