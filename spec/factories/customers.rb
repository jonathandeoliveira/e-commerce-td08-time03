FactoryBot.define do
  factory :customer do
    name { 'Marina Maitê Barbosa' }
    full_adress { 'Rua Figueiredo Teles 299, Lagoa Azul - AP' }
    registration_number { '677.186.157-48' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
