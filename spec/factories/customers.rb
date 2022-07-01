FactoryBot.define do
  factory :customer do
    name { 'Marina Maitê Almeida' }
    full_adress { 'Rua Figueiredo Teles 299, Lagoa Azul - AP' }
    registration_number { '687.186.157-48' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
