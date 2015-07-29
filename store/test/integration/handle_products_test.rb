require 'test_helper'

class HandleProductsTest < ActionDispatch::IntegrationTest
  def setup
    @product=products(:tablexxl)
  end
  test "create valid product" do
    get new_product_path
    assert_difference 'Product.count', 1 do
      post_via_redirect products_path, product: { name:  "Example Product",
                                            description: "description should be long",
                                            image_url:             "valid_image_url.jpg",
                                            price: 100  }
    end
  assert_template 'products/show'
  end

  test "create invalid product" do
    get new_product_path
    assert_difference 'Product.count', 0 do
      post_via_redirect products_path, product: { name:  "   ",
                                            description: " ",
                                            image_url:             "invalid_image_u.rljpg",
                                            price: "string"  }
    end
    assert_template 'products/new'
  end

  test "succesful edit product" do
    get edit_product_path(@product)
    assert_response :success
    name="new name"
    description="new description"
    image_url="new_image_url.jpg"
    price=20
    patch product_path(@product), product: { name:  name,
                                    description: description,
                                    image_url: image_url,
                                    price: price }
    assert_redirected_to @product
    @product.reload
    assert_equal name, @product.name
    assert_equal description, @product.description
    assert_equal image_url, @product.image_url
    assert_equal price, @product.price
    assert_redirected_to @product
    assert_not flash.empty?
  end

  test "unsuccesful edit product" do
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
