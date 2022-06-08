FactoryBot.define do
  factory :product_model do
    name { "MyString" }
    brand { "MyString" }
    sku { "MyString" }
    fragile { false }
    description { "MyString" }
    weight { 1.5 }
    height { 1.5 }
    width { 1.5 }
    length { 1.5 }
  end
end
