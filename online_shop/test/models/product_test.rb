require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(name:"Example name", description: "Example description", price: 1000 )
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.name = ""
    assert_not @product.valid?
  end

  test "desctiption should be present" do
    @product.description = "    "
    assert_not @product.valid?
  end

  test "price should be present" do
    @product.price = ""
    assert_not @product.valid?
  end

  test "create product" do
    get new_product_path
    assert_difference 'Product.count', 1 do
      post_via_redirect products_path, product: { name:"Example name", description: "Example description", price: 1000 }
    end
    assert_template 'products'
  end
end
