require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name:"Example User",email:"user@example.com",user_id:"emaple")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "  "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "  "
  	assert_not @user.valid?
  end

  test "user_id should be present" do
  	@user.user_id = "  "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*256
    assert_not @user.valid?
  end

  test "user_id should not be too long" do
    @user.user_id = "a"*51
    assert_not @user.valid?
  end
end
