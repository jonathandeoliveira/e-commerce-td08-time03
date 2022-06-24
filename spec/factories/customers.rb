FactoryBot.define do
  factory :customer do
    name { 'Marina Maitê Barbosa' }
    full_adress { 'Rua Figueiredo Teles 299, Lagoa Azul - AP' }
    registration_number { '677.186.107-48' }
    email { 'marina_maite@gmail.com' }
    password { 'password' }
  end
end
