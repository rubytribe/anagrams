require 'test_helper'
#@product.image_url = File.new("test/fixtures/500.jpg")
class HandleProductsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:raul)
    @product = products(:tablexxl)
  end

  test "succesful edit product" do
    log_in_as(@user)
    get edit_product_path(@product)
    assert_response :success
    name="new name"
    description="new description"
    image_url=fixture_file_upload('test/fixtures/500.jpg', 'image/jpg')
    price=20
    patch product_path(@product), product: { name:  name,
                                    description: description,
                                    image_url: image_url,
                                    price: price }
    assert_redirected_to @product
    @product.reload
    assert_equal name, @product.name
    assert_equal description, @product.description
    assert_equal price, @product.price
    assert_redirected_to @product
    assert_not flash.empty?
  end

  test "unsuccesful edit product" do
    log_in_as(@user)
    get edit_product_path(@product)
    assert_template "products/edit"
    name="  "
    description="  "
    image_url="new_image_url.j.p.g"
    price="sss"
    patch product_path(@product), product: { name:  name,
                                    description: description,
                                    image_url: image_url,
                                    price: price }
    assert_template "products/edit"
  end

  test "delete product from index" do
    assert_difference 'Product.count', -1 do
      @product.destroy
    end
  end

  test "delete product from product page" do
    get product_path(@product)
    assert_difference 'Product.count', -1 do
      @product.destroy
    end
  assert_template 'products/show'
  end


end
