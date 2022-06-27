class Order < ApplicationRecord
  belongs_to :customer
  has_many :product_items
  before_create :generate_code
  after_create :associate_products_to_order

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def associate_products_to_order
      ProductItem.where(order_id: nil, customer: self.customer).each do |p|
      p.update(order_id: self.id)
    end
  end
end
