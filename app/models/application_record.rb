class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def actual_price
    product_prices.where('start_date <= ? AND end_date >= ? ', DateTime.now, DateTime.now).first.price
  end
end
