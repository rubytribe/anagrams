require 'test_helper'

class CreateProductTest < ActionDispatch::IntegrationTest

  test "invalid create information" do
    @user = users(:raul)
    log_in_as @user
    get new_product_path
    assert_no_difference 'Product.count' do
      post products_path, product: { name: "",
                                     description: "invalid",
                                     image_url: "invalid.jpg",
                                     price: 10
                                   }
    end
    assert_not flash.empty?
    assert_template 'products/new'
  end

  test "valid create information" do
    @user = users(:raul)
    log_in_as @user
    get new_product_path
    assert_difference 'Product.count', 1 do
      post_via_redirect products_path, product: { name: "bookname",
                                                  description: "interesting",
                                                  image_url: fixture_file_upload('test/fixtures/500.jpg',
                                                                                  'image/jpg'),
                                                  price: 30 }
    end
    assert_not flash.empty?
    assert_template 'products/show'
  end
end
