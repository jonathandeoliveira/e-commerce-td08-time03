FactoryBot.define do
  factory :order do
    customer
    total_value { "9.99" }
    address {customer.full_adress}
  end
end