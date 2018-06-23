class Product
  attr_accessor :price, :product_code, :name

  def initialize(product_code, name, price, no_validate = false)
    @product_code = product_code
    @name = name
    @price = BigDecimal(price)

    validate if no_validate == false
  end

  def validate
    [product_code, name, price].each do |parameter|
      raise ArgumentError, "ProductParameterMissing" if parameter.nil?
    end
  end
end
