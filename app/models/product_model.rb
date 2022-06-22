class ProductModel < ApplicationRecord
  belongs_to :sub_category
  enum status: { enabled: 0, disabled: 10 }
  validates :name, :brand, :model, :sku, :description, :weight, :height, :width, :length, presence: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }
  validates :sku, uniqueness: true
  validates :sku, length: { minimum: 8 }
  has_many :product_prices
  has_one_attached :manual


  def set_current_price
    current_price = product_prices.where('start_date <= ? AND end_date >= ? ', DateTime.now, DateTime.now)
    current_price.price
  end
end
