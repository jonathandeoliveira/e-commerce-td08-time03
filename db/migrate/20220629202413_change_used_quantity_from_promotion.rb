class ChangeUsedQuantityFromPromotion < ActiveRecord::Migration[7.0]
  def change
    change_column :promotions, :used_quantity, :integer, default: 0
  end
end
