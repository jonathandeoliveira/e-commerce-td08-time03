class ProductModel < ApplicationRecord
  belongs_to :sub_category
  enum status: { enabled: 0, disabled: 10 }
  validates :name, :brand, :model, :sku, :description, :weight, :height, :width, :length, presence: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }
  validates :sku, uniqueness: true
  validates :sku, length: { minimum: 8 }
  has_many :product_prices

 
  def get_current_price(product_model_id)
    price = ProductPrice.joins(:product_model).where('product_model_id == ? AND start_date <= ? AND end_date >= ? ',product_model_id, DateTime.now, DateTime.now)
    return price[0]
  end
end

