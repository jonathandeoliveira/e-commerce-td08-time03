class Promotion < ApplicationRecord  
  enum status: { inactive:0, active: 1 }
  has_many :promotion_categories
  has_many :sub_categories, :through => :promotion_categories
end
