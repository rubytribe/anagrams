require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "sign up with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "   ",
                               email:"invalid@email",
                               password: "aaa",
                               confirm_password:"bbb"  }
    end
    assert_template 'users/new'
  end

  test "sign up with valid information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "raoul",
                               email:"raoul@raul.com",
                               password: "password",
                               confirm_password:"password"  }
    end
    assert_template 'users/show'
  end
  
end
