require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
  	get signup_path
  	assert_select 'form[action="/signup"]'
  	assert_no_difference 'User.count' do
  		post signup_path,params: {user: {name: "",
  										                email: "user@invalid",
                                      user_id: "invalid.user",
  										                password: "foo",
  										                password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	# した二つはエラーよるPartialまんまのテスト
  	assert_select "div#error_explanation div.alert"
  	assert_select "div#error_explanation ul"
  	# 無効な内容が送信されて元のページに戻されるときにRailsが返してくれる
  	# エラー用divタグのCSSクラスのfield_with_errorsに関するテスト
  	assert_select "div .field_with_errors"
  end

  test "valid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count',1 do
      post signup_path,params: {user: {name: "Eample User",
                                      email: "user@example.com",
                                      user_id: "valid.user",
                                      password: "password",
                                      password_confirmation: "password"}}
    end
    follow_redirect!
    #指定されたリダイレクトに移動↑
    assert_template 'users/show'
    #flashが表示されるか確認
    assert flash.any?
    #login出来てるか確認
    assert is_logged_in?
  end
end
