module Promotional
  module Rule
    class QuantityPrice < PromotionalRule
      attr_reader :minimum_quantity, :value

      def initialize(minimum_quantity, value, no_validate = false)
        @minimum_quantity = minimum_quantity
        @value = value

        validate if no_validate == false
        end

      def eligible?(item)
        item.quantity >= minimum_quantity
        end

      def calculate_discounted_price(basket_item, discount_type)
        if discount_type == "percentage" && basket_item.quantity > minimum_quantity
          basket_item.product.price = ((basket_item.product.price.to_f * value.to_f) / 100)
        elsif discount_type == "flat_rate" && basket_item.quantity > minimum_quantity
          basket_item.product.price = value
        end
        end

      def calulate_total_discounted_price(total); end

      def validate
        should_be_present("QuantityPrice::Value", value)
        should_be_a_number("QuantiyPrice::MinimumQuantity", minimum_quantity)
        should_be_less_than("QuantityPrice::MinimumQuantity", minimum_quantity, 1)
        end
      end
  end
end
