require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
  	get signup_path
  	assert_select 'form[action="/signup"]'
  	assert_no_difference 'User.count' do
  		post signup_path,params: {user: {name: "",
  										email: "user@invalid",
  										password: "foo",
  										password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	# した二つはエラーようPartialまんまのテスト
  	assert_select "div#error_explanation div.alert"
  	assert_select "div#error_explanation ul"
  	# 無効な内容が送信されて元のページに戻されるときにRailsが返してくれる
  	# エラー用divタグのCSSクラスのfield_with_errorsに関するテスト
  	assert_select "div .field_with_errors"
  end
end
