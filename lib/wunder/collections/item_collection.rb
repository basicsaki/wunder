class ItemCollection < Array
  def find_product(product_code)
    @item = nil
    each do |item|
      @item = item if item.product.product_code == product_code
    end

    @item
  end
end
