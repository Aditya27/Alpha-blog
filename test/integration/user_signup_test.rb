require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "valid user signup" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "testuser", email: "john@example.com", password: "password", admin: false }
    assert_template 'users/show'
    assert_match "testuser", response.body
    assert_select 'div.alert-success'
    end

  end

end