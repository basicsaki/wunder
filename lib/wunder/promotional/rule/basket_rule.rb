module Promotional
  module Rule
    class BasketRule < PromotionalRule
      attr_reader :value

      def initialize(value, no_validate = false)
        @value = value

        validate if no_validate == false
      end

      def adjustable?(total)
        return true if total > value
        false
      end

      def eligible?(_item)
        false
      end

      def calculate_total_discounted_price(total, discount_type)
        if discount_type == "percentage"
          discount_price = total - ((total * value) / 100)
        elsif discount_type == "flat_rate"
          discount_price = total
        end

        discount_price
      end

      def validate
        should_be_present("BasketRule::Value", value)
        should_be_a_number("BasketRule::Value",
                           value)
        should_be_more_than("BasketRule::MinQuantity",
                            value, 1)
      end
    end
  end
end
