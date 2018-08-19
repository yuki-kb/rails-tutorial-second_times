require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "ogin with invalid information" do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path,params: {session:{email:"",password:""}}
  	assert_template 'sessions/new'
  	assert flash.any?
  	get root_path
  	assert_not flash.any?
  end

end
