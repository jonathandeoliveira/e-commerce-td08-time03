FactoryBot.define do
  factory :order do
    code { "MyString" }
    total_value { "9.99" }
    customer { nil }
  end
end
