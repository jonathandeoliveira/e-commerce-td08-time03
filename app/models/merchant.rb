class Merchant < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, format: { with: /\A[\w\-\+]+@mercadores.com.br\z/ }
end
