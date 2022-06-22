class ProductItem < ApplicationRecord
  belongs_to :customer
  belongs_to :product_model
end
