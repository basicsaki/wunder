require_relative "./basket_item.rb"
require_relative "./collections/item_collection.rb"

class Basket
  attr_accessor :items

  def initialize
    @items = ItemCollection.new
  end

  def add_item(product)
    item = items.find_product(product.product_code)
    if item.nil?
      items.push(BasketItem.new(product))
    else
      item.increment_item_quantity
    end
  end

  def remove_item(product)
    item = items.find_product(product.product_code)
    if item.quantity == 1
      items.delete(item)
    else
      item.decrement_item_quantity
    end
  end

  def items_in_basket
    codes = []
    items.each do |p|
      codes << p.split(",")[0]
    end

    codes
  end
end
