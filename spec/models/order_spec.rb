require 'rails_helper'

RSpec.describe Order, type: :model do
  subject do
    order = build(:order, code: 'QUINZCARACTERES')
  end
  it { should validate_presence_of(:total_value) }
  it { should validate_presence_of(:address) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_length_of(:code).is_at_least(15) }
end
