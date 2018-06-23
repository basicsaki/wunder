require_relative "./wunder.rb"
# initiate parsing csv file

# Parser
# new expects csv file path,validate {true or false},use mock file true or false
parser = Parser.new("", true, true)
parser.process_file

# Product Collection
products = parser.products

# promotion
promotion = Promotion.new("new_year", "1234")

# rules
item_quantity_rule = Promotional::Rule::QuantityPrice.new(1, 10)

# promotional rules
promotion_rule = PromotionalRule.new("Flat discount on prices", "flat_rate", true, item_quantity_rule)
promotion.add_rule(promotion_rule)

# promotional Rules
# Checkout interface
# scan(item) #remove_scan(item)

co = Checkout.new(promotion.promotion_rules)

co.scan(products.first)
co.scan(products.first(3).last)
co.scan(products.first(3).last)

co.scan(products.last)

price = co.total

table = Print.new([co]).table

puts table
