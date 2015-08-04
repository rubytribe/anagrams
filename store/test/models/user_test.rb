require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated products should be destroyed" do
    @user.save
    @user.products.create!(name: "Lorem ipsum",description: 'description',
    image_url:   File.new('test/fixtures/500.jpg'), price: 20)
    assert_difference 'Product.count', -1 do
      @user.destroy
    end
  end
end
