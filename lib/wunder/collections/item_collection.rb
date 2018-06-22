class ItemCollection < Array
  def find_product(product_code)
    each do |item|
      @item = item if item.product.product_code == product_code
    end

    @item
  end
end
