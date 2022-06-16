FactoryBot.define do
  factory :product_price do
    price { "9.99" }
    start_date { "2022-06-15" }
    end_date { "2022-07-15" }
    product_model { nil }
  end
end
