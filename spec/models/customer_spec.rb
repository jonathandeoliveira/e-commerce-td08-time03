require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#valid?' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:registration_number)}
    it {should validate_presence_of(:full_adress)}
    it {should validate_presence_of(:balance)}
    it { should allow_value('17.319.604/0001-06').for(:registration_number) }
    it { should allow_value('940.440.800-03').for(:registration_number) }
    it { should_not allow_value('12345678910').for(:registration_number) }
    it { should_not allow_value('12345678000190').for(:registration_number) }
    it { should validate_uniqueness_of(:registration_number) }
    it {should validate_numericality_of(:balance)}

  end
  
end

