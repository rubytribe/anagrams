require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @user = users(:cristi)
    @product = products(:one)
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

  test "description should be at least 140 characters" do
    @product.description = "a" * 141
    assert_not @product.valid?
  end

  test "name should be at least 50 characters" do
    @product.name = "a" * 51
    assert_not @product.valid?
  end
end
