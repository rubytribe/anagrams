require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end
  test "product attributes should not be empty" do
    empty_product=Product.new
    assert empty_product.invalid?
    assert empty_product.errors[:name].any?
    assert empty_product.errors[:description].any?
    assert empty_product.errors[:image_url].any?
    assert empty_product.errors[:price].any?
  end
end
