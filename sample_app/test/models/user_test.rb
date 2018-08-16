require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name:"Example User",email:"User@example.com",
                    user_id:"Example",password:"foobar",
                    password_confirmation:"foobar")
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

  test "email validation should acept valid addresses" do
    valid_addresses = %w[user@example.com User@foo.COM
                        A_US-ER@foo.bar.org first.last@foo.jp
                        alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email= valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org
                          user.came@example. foo@bar_baz.com
                          foo@bar+baz.com user@example..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?,"#{invalid_address.inspect} should be invalid"
    end
  end

  test "user_id validation should acept valid user_id" do
    valid_user_ids = %w[users User.foo A-ER.bar first-last 24156
                        user2 User.3fo A-4hd]
    valid_user_ids.each do |valid_user_id|
      @user.user_id= valid_user_id
      assert @user.valid?, "#{valid_user_id.inspect} should be valid"
    end
  end

  test "user_id validation should reject invalid user_id" do
    invalid_user_ids = %w[user@ +83bfj _8fbicn ,nahoj
                          /gafsa \gags |asfs ga~53 =jfna \fnjsc
                          !dajbi #ndjab $fnan %nfaln &njlfa
                           :fnaa ;kanfpa <fanpa ]
    invalid_user_ids.each do |invalid_user_id|
      @user.user_id = invalid_user_id
      assert_not @user.valid?,"#{invalid_user_id.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    duplicate_user.user_id = "test"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "user_id should be unique" do
    duplicate_user = @user.dup
    duplicate_user.user_id = @user.user_id.upcase
    duplicate_user.email = "test@gmail.com"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase,@user.reload.email
  end

  test "user_id should be saved as lower-case" do
    mixed_case_user_id = "FooExAMPle.CoM"
    @user.user_id = mixed_case_user_id
    @user.save
    assert_equal mixed_case_user_id.downcase,@user.reload.user_id
  end
end
