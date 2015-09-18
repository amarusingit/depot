require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
	
	def new_product()
		LineItem.new( cart: ,
			product: ,
			price: 15.5,
			quantity: 10)
	end
end
