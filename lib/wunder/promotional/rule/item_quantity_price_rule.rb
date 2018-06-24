module Promotional
  module Rule
    class ItemQuantityPriceRule < PromotionalRule
      attr_reader :minimum_quantity, :value

      def initialize(minimum_quantity, value, no_validate = false)
        @minimum_quantity = minimum_quantity
        @value = value

        validate if no_validate == false
      end

      def eligible?(item)
        item.quantity >= minimum_quantity
      end

      def adjustable?(_total)
        false
      end

      def calculate_discounted_price(basket_item, discount_type)
        if discount_type == "percentage"
          discount = compute_discount(basket_item)
          basket_item.product.price = discount
        elsif discount_type == "flat_rate"
          basket_item.product.price = value
        end
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
        should_be_present("ItemQuantityPriceRule::Value", value)
        should_be_a_number("ItemQuantityPriceRule::MinimumQuantity",
                           minimum_quantity)
        should_be_more_than("ItemQuantityPriceRule::MinQuantity",
                            minimum_quantity, 1)
      end

      private

      def compute_discount(basket_item)
        discount = (basket_item.product.price * value) / 100
        basket_item.product.price - discount
      end
    end
  end
end
