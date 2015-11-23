class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.decimal :curs, precision: 8, scale: 4
      t.date :datecurs
      t.timestamps null: false
    end
  end
end
