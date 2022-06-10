class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.string :brand
      t.string :sku
      t.string :model
      t.boolean :fragile, default: false
      t.string :description
      t.float :weight
      t.float :height
      t.float :width
      t.float :length
      t.timestamps
    end
  end
end
