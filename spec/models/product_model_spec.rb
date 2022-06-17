require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:model) }
    it { should validate_presence_of(:sku) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:width) }
    it { should validate_presence_of(:length) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
    it { should validate_numericality_of(:length).is_greater_than(0) }
    it { should validate_numericality_of(:height).is_greater_than(0) }
    it { should validate_numericality_of(:width).is_greater_than(0) }
    it { should validate_uniqueness_of(:sku) }
    it { should validate_length_of(:sku).is_at_least(8) }
    it { should define_enum_for(:status) }
  end
end
