class ProductPrice < ApplicationRecord
  validates :price, :start_date, :end_date, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :date_is_future, :start_date_differs_from_end_date, :end_date_is_future_from_start_date 
  validate :price_unique_within_dates

  belongs_to :product_model, optional: true

  private 
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

  def price_unique_within_dates
    if self.price.present? && self.start_date.present? && self.end_date.present?
      prices = ProductPrice.where(product_model: self.product_model_id) - [self]
      prices.each do | price |
        if (self.start_date >= price.start_date && self.start_date <= price.end_date) || (self.end_date >= price.start_date && self.end_date <= price.end_date)
          self.errors.add(:price, ' não pode ser cadastrado, pois está incluso em intervalo de datas já existentes')
        end
      end
    end    
  end
end
