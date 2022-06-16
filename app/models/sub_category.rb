class SubCategory < ApplicationRecord
  belongs_to :category
  enum status: { enabled: 10, disabled: 0 }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
