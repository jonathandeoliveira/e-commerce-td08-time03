FactoryBot.define do
  factory :product_item do
    customer
    product_model
    quantity { 1 }
  end
end
