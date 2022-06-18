class AddSubCategoryToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_models, :sub_category, null: false, foreign_key: true
  end
end
