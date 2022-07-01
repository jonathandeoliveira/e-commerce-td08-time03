class AddPromotionToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :promotion, :string
  end
end
