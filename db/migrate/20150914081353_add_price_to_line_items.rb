class AddPriceToLineItems < ActiveRecord::Migration
  def change
    	add_column :line_items, :price, :decimal, precision: 8, scale: 2

     	# Копируем цену товара из таблицы products в товарные позиции line
 		line_items.all.each do |line_item|
 			if products.find_by?(product_id: line_item.product_id)
	 			line_item.price = products.find_by(product_id: line_item.product_id).price
	 		elseif
	 			line_item.price = 0
	 		end
 		end
  end
end
