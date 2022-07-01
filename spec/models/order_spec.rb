require 'rails_helper'

RSpec.describe Order, type: :model do
  subject do
    order = create(:order, code: 'QUINZCARACTERES')
  end
  it { should validate_presence_of(:total_value) }
  it { should validate_presence_of(:address) }
  xit { should validate_uniqueness_of(:code) }
  xit { should validate_length_of(:code).is_at_least(15) }
end
