require "terminal-table"
require "money"

class Print
  attr_reader :checkouts

  def initialize(checkouts)
    @checkouts = checkouts
  end

  def table
    rows = []
    headings = ["", "Items In basket", "Applied Promo Rules", "Total Price"]
    checkouts.each_with_index do |checkout, index|
      price = Money.new(checkout.total * 100).format
      items = checkout.basket.items_in_basket
      applied_promotional_rules = checkout.applied_promotional_rules

      rows << ["Test_#{index}", items, applied_promotional_rules, price]
    end
    Terminal::Table.new headings: headings, rows: rows
  end
end
