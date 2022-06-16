FactoryBot.define do
  factory :sub_category do
    name { Faker::Commerce.department }
    status { 10 }
    category_id { 1 }
  end
end
