require 'test_helper'

class DepotShippingTest < ActionDispatch::IntegrationTest

 	test "shipping_a_order" do
    
 		post_via_redirect "/login", name: users(:one).name, password: "secret"
    	assert_template "admin/index"
    	assert_equal users(:one).id, session[:user_id]

  		get "/orders"
		assert_response :success
		assert_template "index"

		get "/orders/#{orders(:one).id}/edit"
		assert_response :success
		assert_template "edit"

		patch_via_redirect "/orders/#{orders(:one).id}",
                {order: { name:       orders(:one).name,
                        address:     orders(:one).address,
                        email:       orders(:one).email,
                        pay_type:    orders(:one).pay_type},
                        shipped: "1"}  

		assert_response :success
		assert_template "index"
		
		order = Order.find_by(id: orders(:one).id)

		assert_equal Time.zone.now.to_i/10.to_i, order.ship_date.to_i/10.to_i

		mail = ActionMailer::Base.deliveries.last
		assert_equal ["dave@example.org"], mail.to
		assert_equal 'Sam Ruby <depot@fancy_gifts_shop.net>', mail[:from].value
		assert_equal "Заказ из Pragmatic Store отправлен", mail.subject

	end
end
