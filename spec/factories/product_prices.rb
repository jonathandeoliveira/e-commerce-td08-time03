FactoryBot.define do
  factory :product_price do
    price { "9.99" }
    start_date { Date.today}
    end_date { 3.months.from_now }
    product_model { nil }
  end
end
