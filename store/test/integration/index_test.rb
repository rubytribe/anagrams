require 'test_helper'

class IndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:raul)
    @other_user = users(:george)
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

  test "index as admin including pagination and delete links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'

    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'Show'
      unless user == @user
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test "index as non-admin" do
    log_in_as(@other_user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
