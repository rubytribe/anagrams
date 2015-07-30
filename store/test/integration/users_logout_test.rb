require 'test_helper'

class UsersLogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:raul)
  end

  test "user logout successfully" do
    get login_path
    post login_path session: { email: @user.email, password: 'password' }
    follow_redirect!
    assert_select 
  end
end
