class ProductCollection < Array
  def find_by_product_code(code)
    each do |product|
      @fetch_product = product if product.product_code == code
    end

    @fetch_product
  end

  def validate_product_code_is_uniq(code)
    find_by_product_code(code).nil? ? true : (raise "DuplicateProductCodeError")
  end
end
