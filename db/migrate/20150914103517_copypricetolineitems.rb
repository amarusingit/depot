class Copypricetolineitems < ActiveRecord::Migration
	def up
  		LineItem.all.each do |line_item|
  			unless line_item.product.nil?
  				line_item.price = line_item.product.price
  				line_item.save!
  			end	
 		end	
	end

	def down
	end
end
