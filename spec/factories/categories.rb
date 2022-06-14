require 'faker'

FactoryBot.define do  
  factory :random_category, class: 'category' do
    name { Faker::Commerce.department }
    status { 0 }
  end
end
