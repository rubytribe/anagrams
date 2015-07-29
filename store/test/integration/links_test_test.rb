require 'test_helper'

class LinksTestTest < ActionDispatch::IntegrationTest
  test " links" do
   get root_path
   assert_template 'pages/home'
   assert_select "a[href=?]", root_path
   assert_select "a[href=?]", about_path
   assert_select "a[href=?]", contact_path
   #assert_select "a[href=?]", signup_path
   #assert_select "a[href=?]", login_path
  end
end
