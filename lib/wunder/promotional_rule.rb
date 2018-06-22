class PromotionalRule

attr_reader :on_item,:minimum_quantity,:item_keyword,:flat_rate,:percentage_discount,:minimum_purchase

def initialize(flat_rate,percentage_discount)

	@flat_rate = flat_rate
	@percentage_discount = percentage_discount

end

def validate
	either_should_be_present(flat_rate,percentage_discount)  
end

private

def either_should_be_present attribute_1,attribute_2
	raise "atleast fill out #{attribute_1} or #{attribute_2}" if (attribute_1.empty? && attribute_2.empty? )
end

def atleast_one_should_be_present attribute_1,attribute_2
	raise "either fill out #{attribute_1} or a #{attribute_2}" if (attribute_1.empty? == false && attribute_2.empty? == false )
end

def should_be_a_number attribute
	raise "#{attribute} should be a number" if (attribute.is_a? Numeric == false) 
end

def should_be_less_than attribute,number
	raise "#{attribute} should be greater than #{number}" if (attribute < number)
end


end

=begin


BasketPrefixes = [
									"on all products",
									"on basket",
									"off your purchase",
									"off your total purchase"
								] 

ItemPrefixes = [
								/[0-9]?[0-9][0-9]? or more/,
								/greater than [0-9]?[0-9][0-9]?/,
								/more than [0-9]?[0-9][0-9]?/,
								/based products/
							]


promotional_rule = {
	:on_item=>true, :discount_in_percentage=>true,:price=>calculate_adjustment(value_in_percentage),:item_keyword=>"Pizza"
	:on_item => false
}


def process_promotional_rule
	Item_regex = Regexp.union(prefixes)

	if rule.match(re)


  if rule_type == "on_item"
end

def 

#price based
def price_based_rule

end

def price_based_rule?

end


def quantity_based_rule

end


def quantity_based_rule?

end

def check_rule_type

end

end
=end