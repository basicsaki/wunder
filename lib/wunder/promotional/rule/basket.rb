require_relative "../../promotional_rule.rb"

		class Promotional::Rule::Basket < PromotionalRule

			attr_reader :minimum_quantity,:maximum_quantity,:item_keywords

			def initialize(flat_rate,percentage_discount,minimum_purchase_amount,maximum_purchase_amount)
				super
				
				@minimum_purchase_amount = minimum_purchase_amount
				@maximum_purchase_amount = maximum_purchase_amount

				validate
			end

			def validate
				super 

				unless minimum_purchase_amount.blank?
					should_be_a_number(minimum_purchase_amount)
					should_not_be_less_than(minimum_purchase_amount,0)
				end

				unless maximum_purchase_amount.blank? && minimum_purchase_amount.blank?
					should_be_a_number(maximum_purchase_amount)
					should_not_be_less_than(maximum_purchase_amount,minimum_purchase_amount)
				end

			end

			def eligible?(item)
				if (item.price > minimum_purchase_amount) && (item.price < maximum_purchase_amount)
					true 
 				else
 					false
 				end 
			end

end
