class AddLocaleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :locale, :varchar
  end
end
