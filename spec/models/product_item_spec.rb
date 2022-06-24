require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  describe '#valid?' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:product_model_id) }
    it { should validate_presence_of(:customer_id) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
