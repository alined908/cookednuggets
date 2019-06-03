require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {firstname: "Daniel", lastname: "Lee", username: "alined",
        email:"daniel@gmail.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
