class Category < ApplicationRecord

  validates :name, :status, presence: true
  
  enum status: { Ativa: 0, Inativa: 5 }
end
