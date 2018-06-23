require "csv"

require_relative "./product.rb"
require_relative "./collections/product_collection.rb"

class Parser
  attr_accessor :path, :products

  # initialize a new conference settings
  def initialize(path = "", no_validate = false, use_mock_file = false)
    @path = (use_mock_file == true ? mock_file_path : path)
    validate if no_validate == false
  end

  def validate
    err_msg = "No such file found"
    raise err_msg.to_s if path == "" || path.nil? || File.exist?(path) == false
  end

  def process_file
    @products = ProductCollection.new

    CSV.foreach(path, col_sep: ",", row_sep: :auto, headers: true) do |row|
      product = Product.new(row[0], row[1], row[2])
      next unless @products.validate_product_code_is_uniq(product.product_code)
      @products << product
    end

    @products
  end

  # incase file is not provided
  def mock_file_path
    source = __dir__
    File.join(source, "input/input.csv")
  end
end
