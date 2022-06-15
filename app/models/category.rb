class Category < ApplicationRecord
  validates :name, :status, presence: true

  enum status: { enabled: 0, disabled: 5 }
end
