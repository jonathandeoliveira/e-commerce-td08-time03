class Category < ApplicationRecord
  validates :name, :status, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :sub_categories
  enum status: { enabled: 0, disabled: 5 }
end
