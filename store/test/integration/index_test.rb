require 'test_helper'

class IndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:raul)
    @product = products(:tablexxl)
  end

  test "user index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  #  assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: "Show"
    end
  end

  test "product index including pagination" do
    get products_path
    assert_template 'products/index'
  #  assert_select 'div.pagination'
    Product.paginate(page: 1).each do |product|
      assert_select 'a[href=?]', product_path(product), text: "Show"
    end
  end

end
