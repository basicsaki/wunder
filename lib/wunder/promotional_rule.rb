class PromotionalRule

attr_reader :discount_type,:on_item,:rule

DISCOUNT_TYPES = ["percentage","flat_rate"]

def initialize(discount_type,on_item,rule,no_validate = false)
	@discount_type = discount_type
	@on_item = on_item
	@rule = rule

	validate if no_validate == false
end

def eligible?
	raise "Should be defined by the respective rule"
end

def validate
	check_discount_type(discount_type)
	should_be_a_boolean("PromotionaRule::OnItem",on_item)
	should_be_present("PromotionalRule::Rule",rule) 
end

private

def should_be_present name,attribute
	raise "#{attribute} Should be present" if attribute == "" || attribute == nil
end

def check_discount_type discount_type
	raise "Discount type can only be a 'percentage' or 'flat_rate'" if DISCOUNT_TYPES.include?(discount_type) == false
end

def either_should_be_present name,attribute_1,attribute_2
	raise "atleast fill out #{name}" if (attribute_1.empty? && attribute_2.empty? )
end

def atleast_one_should_be_present name,attribute_1,attribute_2
	raise "either fill out #{name}" if (attribute_1.empty? == false && attribute_2.empty? == false )
end

def should_be_a_number name,attribute
	raise "#{attribute} should be a number" if (attribute.is_a?(Numeric) == false) 
end

def should_be_less_than name,attribute,number
	raise "#{name} should be greater than #{number}" if (attribute < number)
end

def should_be_a_boolean  name,attribute
	raise "#{name} should be a boolean" if (boolean?(attribute) == false)  
end

def boolean? attribute
	binding.pry
	["true","false",true,false].include? attribute
end


end