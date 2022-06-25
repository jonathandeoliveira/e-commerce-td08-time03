class ProductItem < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }
  validates :customer_id, :product_model_id, :quantity, presence: true
  belongs_to :customer
  belongs_to :product_model

  def calculate_total_product_values
    product_model.actual_price * quantity
  end
end
