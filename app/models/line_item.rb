class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :cart

	validates :quantity, :price, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :quantity, numericality: {greater_than_or_equal_to: 1}

	def total_price
 		price * quantity
	end
end
