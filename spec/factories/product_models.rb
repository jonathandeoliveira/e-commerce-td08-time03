require 'faker'

FactoryBot.define do
  factory :product_model do
    sequence(:name) { |n| "Notebook-#{n}" }
    brand { "Dell" }
    model { "Inspiron 15" }
    sequence(:sku) { |n| "DELL948297#{n}" }
    fragile { false }
    description { "Notebook 15 processador intel i7" }
    weight { 6 }
    height { 0.3 }
    width { 0.45 }
    length { 0.15 }
  end
end