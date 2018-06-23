require "terminal-table"
require "money"

class Print
  attr_reader :checkouts

  def initialize(checkouts)
    @checkouts = checkouts
  end

  def table
    rows = []
    checkouts.each_with_index do |checkout, index|
      rows << ["Test_#{index}", checkout.basket.items_in_basket, checkout.applied_promotional_rules, Money.new(checkout.total).format]
    end
    Terminal::Table.new headings: ["", "Items In basket", "Applied Promotional Rules", "Total Price"], rows: rows
  end
end
