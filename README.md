[![Build Status](https://travis-ci.org/basicsaki/wunder.svg?branch=master)](https://travis-ci.org/basicsaki/wunder)


# Wunder

Sample ruby code for a checkout system with flexible rules. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wunder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checkout

## Steps to add a new rule

Create a new file in the folder
	 
	 lib/wunder/promotional/rule/*.rb

Capture any value or paramters in the initialize method.

Make sure that the below mentioned methods are available in the file.

If the discount is on basket define adjustable method as mentioned below.

Total is the parameter after discounts on individual items.
Define calculate_total_discounted_price to compute the new value after discounts.
return false if your rule has only item specific discounts.

      def adjustable?(total)
        return true if total > value
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


If the discount is on an item define eligible method as mentioned below.Item is the individual item scaned during the checkout.
Define calculate_discounted_price to compute the new value after discounts.
return false if your rule has only basket specific discounts.

      def eligible?(_item)
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

Methods in concerns/rule_validations can be used readily to validate the input parameters while capturing the rule.

##Example

An interface example has been added at path wunder/lib/interface.rb to calculate and add existing rules.

	ruby lib/interface.rb

To run the tests
	
	rspec spec

To check rubocop style guidelines

	rubocop 

To check dependent gem venerabilites

	bundle audit


#Note
For rubocop enforcements using a gem sub-inspector for ruby gems.


#Ruby documentation
https://www.rubydoc.info/gems/wunder

##Future Scope
Making seperate modules for checkout,promotional rules and parsing products.
Adding priority to rules as many rules can be applied to many products. The order in which the rules are applied can be be sorted.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/checkout. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Checkout project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/checkout/blob/master/CODE_OF_CONDUCT.md).

