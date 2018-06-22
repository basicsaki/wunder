require "pry"

require_relative "./wunder.rb"
require_relative "./wunder/parser.rb"

require_relative "./wunder/checkout.rb"
require_relative "./wunder/promotional_rule.rb"

require_relative "./wunder/promotion/rules/product.rb"
require_relative "./wunder/promotion/rules/basket.rb"

# initiate parsing csv file

# Parser
parser = Parser.new("", true, true)
parser.process_file

# Product Collection
products = parser.products

promotional_rules = []

binding.pry

# promotional Rules

rule_1 = PromotionalRule.new
promotional_rules = %w[rule_1]

# Checkout interface
# scan(item) #remove_scan(item)

promotional_rules = []

co = Checkout.new(promotional_rules)

co.scan(products.first)
co.scan(products.first)

co.remove_scan(products.first)
co.scan(products.last)
price = co.total
