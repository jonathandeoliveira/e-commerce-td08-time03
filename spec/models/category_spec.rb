require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should define_enum_for(:status) }
  end
end
