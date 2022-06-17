FactoryBot.define do
  factory :sub_category do
    category
    name { Faker::Commerce.department }
    status { 10 }
  end
end
