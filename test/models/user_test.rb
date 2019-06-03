require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(firstname: "Daniel", lastname: "Lee", username: "alined",
      email:"daniel@gmail.com", password: "password", password_confirmation: "password")
  end

  test "user is valid" do
    assert @user.valid?
  end

  test "email addresses should be unique" do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test "email address should be lower case" do
    uppercase_email = "DANIEL@GMAIL.COM"
    @user.email = uppercase_email
    @user.save
    assert_equal uppercase_email.downcase, @user.email
  end

  test "password needs to be same as password confirmation" do
    password = "passw0rd"
    @user.password = password
    @user.save
    assert_not @user.valid?
  end
end
