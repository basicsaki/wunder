require_relative "./wunder.rb"
# initiate parsing csv file

# Parser
# new expects csv file path,validate {true or false},use mock file true or false
parser = Parser.new("", true, true)

label = "Percentage discount on prices"
label1 = "Flat_rate discount on prices"


# rules
quantity_rule1 = Promotional::Rule::ItemQuantityPriceRule.new(1, 10)
quantity_rule2 = Promotional::Rule::BasketRule.new(20)
# promotion
promotion = Promotion.new("New Year Flat Discount", "code_115")

#a promotion rule parameters
#the first parameter is for the label,
#the second is to determine the discount type only values allowed are flat_rate or percentage 
#the third is to determine if the discount is available on item [ true ] or on basket [false]
#the fourth option is the rule that can be custom and defined in lib/wunder/promotional/rule/*.rb
promotion_rule1 = PromotionalRule.new(label, "percentage", true, quantity_rule1)
promotion_rule2 = PromotionalRule.new(label, "flat_rate", true, quantity_rule1)
promotion_rule3 = PromotionalRule.new(label1, "percentage", false, quantity_rule2)
promotion_rule4 = PromotionalRule.new(label1, "flat_rate", false, quantity_rule2)
rules = [promotion_rule1,promotion_rule2,promotion_rule3, promotion_rule4]

#to add in bulk
#the other methods are add_rule / remove_rule
promotion.add_rules_in_bulk(rules)

#File processing
parser.process_file
products = parser.products

# Checkout interface
# scan(item) #remove_scan(item)
co = Checkout.new(promotion.promotion_rules)
co.scan(products[0])
co.scan(products[1])
co.remove_scan(products[1])
co.scan(products[2])

table = Print.new([co]).table

puts table
