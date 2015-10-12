require 'test_helper'

class AdminNotifyingTest < ActionDispatch::IntegrationTest
	fixtures :carts, :users

	test "notifying to admin about unexisting cart access error" do
		
		get "/"
		assert_response :success
		assert_template "index"
		
		session[:user_id] = users(:one).id
		byebug
        get "/carts/#{carts(:one).id}/edit"
		byebug
		assert_response :success
		
		get "/carts/1/edit" 
		

		assert_response :redirect
		assert_redirected_to store_path
		
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["admin@fancy_gifts_shop.net"], mail.to
		assert_equal 'Sam Ruby <depot@fancy_gifts_shop.net>', mail[:from].value
		assert_equal "Error from the site www.depot.com !", mail.subject

	end
end
