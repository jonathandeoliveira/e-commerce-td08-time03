class ProductModel < ApplicationRecord
  validates :name, :brand, :model, :sku, :description, :weight, :height, :width, :length, presence: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }
end
