require 'test_helper'

class ProductsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @product = products(:one)
  end

  test "should destroy" do
    assert_difference 'Product.count', -1 do
      delete product_path(@product)
    end
    assert_not flash.empty?
  end

end
