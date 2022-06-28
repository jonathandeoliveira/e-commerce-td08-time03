class ProductItem < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }
  validates :customer_id, :product_model_id, :quantity, presence: true
  belongs_to :customer
  belongs_to :product_model

  def calculate_total_product_values
    (product_model.current_price.round(2) * quantity)
  end

  def sum_total
    total_value = 0
    total_value += self.calculate_total_product_values
    total_value 
  end
end
