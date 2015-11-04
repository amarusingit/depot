require 'test_helper'

class AuthorizeTest < ActionDispatch::IntegrationTest

 	test "logout_and_logon" do
  #byebug


		get "/"
		assert_response :success
		assert_template "store/index"

		logout
		assert_response :success

  		get "/orders"
  		assert_redirected_to login_url

 		post_via_redirect "/login", name: users(:one).name, password: "secret"
    	assert_template "admin/index"
    	assert_equal users(:one).id, session[:user_id]

  		get "/orders"
		assert_response :success
		assert_template "orders/index"

		get "/logout"
		assert_redirected_to store_url
	end
end
