class PromotionCategory < ApplicationRecord
  belongs_to :promotion
  belongs_to :sub_category
end
