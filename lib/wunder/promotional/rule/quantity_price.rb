module Promotional
module Rule
class QuantityPrice < PromotionalRule

attr_reader :minimum_quantity,:value

	def initialize(minimum_quantity,value,no_validate = false)
		@minimum_quantity = minimum_quantity
		@value = value

		validate if no_validate == false
	end

	def eligible?(quantity)
		quantity >= minimum_quantity ? true : false
	end

	def validate
		should_be_present("QuantityPrice::Value",value)
		should_be_a_number("QuantiyPrice::MinimumQuantity",minimum_quantity)
		should_be_less_than("QuantityPrice::MinimumQuantity",minimum_quantity,1)
	end

end
end
end
