class SubCategory < ApplicationRecord
  belongs_to :category
  enum status: {  disabled: 0, enabled: 10 }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :product_models

  def full_description
    category = self.category.name
    "#{category}: #{name}"
  end
end
