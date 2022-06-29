class Order < ApplicationRecord
  validates :total_value, :address, presence: true
  validates :code, uniqueness: true
  validates :code, length: { minimum: 15 }
  belongs_to :customer
  has_many :product_items
  before_validation :generate_code
  after_create :associate_products_to_order

  enum status: { pending: 0, paid: 5, refused: 10 }

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def associate_products_to_order
    products = customer.product_items.where(order_id: nil)
    products.each do |p|
      p.update(order_id: self.id)
    end
  end
end
