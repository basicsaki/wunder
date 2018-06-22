class BasketItem
  attr_accessor :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increment_item_quantity
    @quantity += 1
    end

  def decrement_item_quantity
    @quantity -= 1
    end
end
