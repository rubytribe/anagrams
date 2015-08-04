require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @user = users(:raul)
    @product = @user.products.build(name: "Lorem ipsum",description: 'description',
    image_url:   File.new('test/fixtures/500.jpg'), price: 20)
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "user id should be present" do
    @product.user_id = nil
    assert_not @product.valid?
  end

end
