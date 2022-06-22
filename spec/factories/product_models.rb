require 'faker'

FactoryBot.define do
  factory :product_model do
    sub_category
    name { Faker::Commerce.product_name }
    brand { "Dell" }
    model { "Inspiron 15" }
    sku { SecureRandom.alphanumeric(8).upcase }
    fragile { false }
    description { "Notebook 15 processador intel i7" }
    weight { 6 }
    height { 0.3 }
    width { 0.45 }
    length { 0.15 }
  end
end
