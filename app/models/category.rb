class Category < ApplicationRecord
  validates :name, :status, presence: true
  has_many :sub_categories
  enum status: { enabled: 0, disabled: 5 }
end
