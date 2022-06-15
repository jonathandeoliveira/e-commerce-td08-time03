class ProductPrice < ApplicationRecord
  belongs_to :product_model, optional: true
end
