require 'test_helper'

class LinksTestTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:tablexxl)
    @user = users(:raul)
  end

  test " links" do
   get root_path
   assert_template 'pages/home'
   assert_select "a[href=?]", root_path
   assert_select "a[href=?]", about_path
   assert_select "a[href=?]", contact_path
   #assert_select "a[href=?]", signup_path
   #assert_select "a[href=?]", login_path
  end

  test "inexistent product link" do
    id = @product.id
    @product.destroy
    get product_path(id)
    assert_redirected_to products_path
    assert_not flash.empty?
  end

  test "inexistent user link" do
    id = @user.id
    @user.destroy
    get user_path(id)
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
