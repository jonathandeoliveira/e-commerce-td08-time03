class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :used_quantity
      t.integer :max_quantity
      t.integer :status, default: 0
      t.integer :discount_percent
      t.decimal :max_discount_money
      t.timestamps
    end
  end
end
