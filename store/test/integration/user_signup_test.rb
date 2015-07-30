require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "sign up with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "   ",
                               email:"invalid@email",
                               password: "aaa",
                               password_confirmation: "bbb"  }
    end
    assert_template 'users/new'
  end

  test "sign up with valid information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "raoul",
                               email:"raoul@raul.com",
                               password: "password",
                               password_confirmation: "password"  }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end

end
