require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup info" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", email: "u@invalid", 
                                         password: "", password_confirmation: "" } }
    end
    assert_template "users/new"
  end
  
  test "valid signup info" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "example", email: "u@valid.com", 
                                         password: "pspsps", password_confirmation: "pspsps" } }
    end
    follow_redirect!
    assert_template "users/show"
  end
end
