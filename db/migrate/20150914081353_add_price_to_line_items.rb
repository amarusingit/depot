class AddPriceToLineItems < ActiveRecord::Migration
  def change
    	add_column :line_items, :price, :decimal, default: 0, precision: 8, scale: 2
  end
end
