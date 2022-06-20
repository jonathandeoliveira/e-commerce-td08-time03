require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  describe '#valid?' do
    subject do
      category = create(:category)
      SubCategory.create!(name: 'Eletronicos', category: category)
    end
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should belong_to(:category) }
    it { should define_enum_for(:status) }
  end
end
