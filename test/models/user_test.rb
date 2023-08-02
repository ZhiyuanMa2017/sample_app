require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "namee", email: "emaill@email.com", 
                     password: "pspsps", password_confirmation: "pspsps")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 246 + "@email.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
                         foo.last@foo.jp alice+bob@zbc.cn]
    valid_addresses.each do |v_a|
      @user.email = v_a
      assert @user.valid?
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com USER_at_foo.COM A_US-ER@foo. 
                         foo@foo_a.jp alice@alice+bob.cn]
    invalid_addresses.each do |i_a|
      @user.email = i_a
      assert_not @user.valid?
    end
  end
  
  test "email address should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end