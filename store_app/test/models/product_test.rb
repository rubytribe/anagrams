require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def setup
    @product = Product.new(title: "Bike", description: "Red", image_url: "bike.jpg", price: 50)
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "title should be present" do
    @product.title = "    "
    assert_not @product.valid?
  end
  
end
