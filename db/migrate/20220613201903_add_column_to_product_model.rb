class AddColumnToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :status, :integer, default: 10
  end
end
