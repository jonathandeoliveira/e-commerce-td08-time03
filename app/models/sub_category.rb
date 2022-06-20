class SubCategory < ApplicationRecord
  belongs_to :category
  enum status: {  disabled: 0, enabled: 10 }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
