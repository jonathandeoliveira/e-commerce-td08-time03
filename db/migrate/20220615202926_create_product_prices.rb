class CreateProductPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :product_prices do |t|
      t.decimal :price
      t.date :start_date
      t.date :end_date
      t.references :product_model, null: true, foreign_key: true

      t.timestamps
    end
  end
end
