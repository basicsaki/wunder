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
quantity_rule_1 = Promotional::Rule::QuantityPrice.new(1, 10)
quantity_rule_2 = Promotional::Rule::QuantityPrice.new(1, 10)

# promotional rules
label_1 = "Flat_rate discount on prices"
label_2 = "percentage discount on prices"

promotion_rule_1 = PromotionalRule.new(label_2, "percentage", true, quantity_rule_2)
promotion_rule_2 = PromotionalRule.new(label_1, "flat_rate", true, quantity_rule_1)


promotion.add_rules_in_bulk([promotion_rule_2,promotion_rule_1])

# promotional Rules
# Checkout interface
# scan(item) #remove_scan(item)

co = Checkout.new(promotion.promotion_rules)

co.scan(products[0])
co.scan(products[1])
co.scan(products[2])

table = Print.new([co]).table

puts table
