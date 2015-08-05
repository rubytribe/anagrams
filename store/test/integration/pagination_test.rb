require 'test_helper'

class PaginationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:raul)
    @products = users(:george).products
  end

  test "user index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'Show'
    end
  end
end
