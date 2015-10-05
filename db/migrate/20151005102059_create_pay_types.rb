class CreatePayTypes < ActiveRecord::Migration
  def change
    create_table :pay_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
