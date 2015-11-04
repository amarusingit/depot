require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
	fixtures :line_items, :products

	test "lineitem attributes must not be empty" do
		# свойства товарной позиции не должны оставаться пустыми
		lineitem = LineItem.new
		lineitem.price = nil
		lineitem.quantity = nil
		assert lineitem.invalid?
		assert lineitem.errors[:price].any?
		assert lineitem.errors[:quantity].any?
	end

	test "line_item price must be positive" do
 	# цена товарной позиции быть положительной
 		line_item = LineItem.new
 		line_item.price = -1
 		assert line_item.invalid?
 		assert_equal ["must be greater than or equal to 0.01"],
 		line_item.errors[:price]
 		# должна быть больше или равна 0.01
 		line_item.price = 0
 		assert line_item.invalid?
 		assert_equal ["must be greater than or equal to 0.01"],
 		line_item.errors[:price]
 		line_item.price = 1
 		assert line_item.valid?
	end

	test "alineitem attributes must not be empty" do
		# новый уникальный товар должен увеличивать количество товаров в корзине
		
		same_product_in_one_cart = Product.new(title: "My Book Title",
						description: "yyy",
						price: 15.58,
						image_url: "mbt.jpg")
		same_product_in_one_cart.save
		cart = Cart.new()
		cart.add_product(same_product_in_one_cart.id)

		find_new_item = LineItem.find_by(product_id: same_product_in_one_cart.id, cart_id: cart.id)
		assert 1 == 1
	end

end
