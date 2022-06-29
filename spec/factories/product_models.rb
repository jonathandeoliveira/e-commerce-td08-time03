require 'faker'

FactoryBot.define do
  factory :product_model do
    sub_category
    name { Faker::Commerce.product_name }
    brand { Faker::Commerce.brand }
    model { "Inspiron 15" }
    sku { Faker::Commerce.promotion_code }
    fragile { false }
    description { Faker::Lorem.paragraph }
    weight { 6 }
    height { 0.3 }
    width { 0.45 }
    length { 0.15 }
  end
end
