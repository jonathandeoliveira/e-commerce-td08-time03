class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product_model, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
