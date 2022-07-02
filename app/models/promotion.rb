class Promotion < ApplicationRecord  
  enum status: { active:0, inactive: 1 }
  has_many :promotion_categories
  has_many :sub_categories, :through => :promotion_categories

  validates :name, :code, :used_quantity, :max_quantity, :discount_percent, :max_discount_money,:status, :start_date, :end_date, :sub_category_ids, :sub_categories, presence: true
  validates :max_quantity, :discount_percent, :max_discount_money , numericality: { greater_than: 0 }
  validates :code, length: { is: 8 }
  validates_associated :sub_categories 
  validate :date_is_future, :start_date_differs_from_end_date, :end_date_is_future_from_start_date
  before_validation :generate_code, on: :create
  

  def check_promotion_validation
    if Date.today > self.end_date || self.used_quantity >= self.max_quantity
     self.inactive!
    end
    self
  end


  private 
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def date_is_future
    if self.start_date.present? && self.start_date < Date.today
      self.errors.add(:start_date,' não pode ser no passado.')
    end
    if self.end_date.present? && self.end_date < Date.today
      self.errors.add(:end_date, ' não pode ser no passado.')
    end
  end

  def start_date_differs_from_end_date
    if self.start_date.present? && self.end_date.present? && self.start_date == self.end_date
      self.errors.add(:start_date, ' e data final não podem ser iguais.')
    end
  end

  def end_date_is_future_from_start_date
    if self.end_date.present? && self.start_date.present? && self.end_date < self.start_date
      self.errors.add(:end_date, ' não pode ser anterior à data inicial.')
    end
  end
end
