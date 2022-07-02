require 'rails_helper'

 RSpec.describe Promotion, type: :model do
  describe '#valid?' do
    subject do 
      sub_category1 = create(:sub_category, name:'Subcategoria1')
      sub_category2 = create(:sub_category, name:'Subcategoria2')
      promotion = create(:promotion, sub_categories:[sub_category1,sub_category2])
    end
    context 'presence' do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:code)}
      it {should validate_presence_of(:start_date)}
      it {should validate_presence_of(:end_date)}
      it {should validate_presence_of(:used_quantity)}
      it {should validate_presence_of(:max_quantity)}
      it {should validate_presence_of(:discount_percent)}
      it {should validate_presence_of(:max_discount_money)}
    end

    it do 
      sub_category1 = create(:sub_category, name:'Subcategoria8')
      sub_category2 = create(:sub_category, name:'Subcategoria9')
      promotion = build(:promotion, sub_categories:[sub_category1,sub_category2])
      should validate_presence_of(:sub_categories)
    end

    context 'numericality' do
      it {should validate_numericality_of(:max_quantity).is_greater_than(0)}
      it {should validate_numericality_of(:discount_percent).is_greater_than(0)}
      it {should validate_numericality_of(:max_discount_money).is_greater_than(0)}      
    end

    context 'code validation' do
      it {should validate_length_of(:code).is_equal_to(8) }
      
      it 'e o código é único' do
        sub_category1 = create(:sub_category, name:'Subcategoria8')
        sub_category2 = create(:sub_category, name:'Subcategoria9')
        promotion = create(:promotion, sub_categories:[sub_category1,sub_category2])
        promotion2 = build(:promotion, sub_categories:[sub_category1,sub_category2])


        promotion2.save!
        expect(promotion2.code).not_to eq promotion.code
      end
    end

    context 'date validation' do
      it 'data inicial não pode ser passada' do
        promotion = build(:promotion, start_date: 2.day.ago)
        
        promotion.valid?

        expect(promotion.errors.include? :start_date).to be true
        expect(promotion.errors[:start_date]).to include(' não pode ser no passado.')
      end

      it 'data final não pode ser passada' do
        promotion = build(:promotion, start_date: Date.today, end_date: 2.day.ago)
        
        promotion.valid?

        expect(promotion.errors.include? :end_date).to be true
        expect(promotion.errors[:end_date]).to include(' não pode ser no passado.')
      end

      it 'data inicial não pode ser igual a data final' do
        promotion = build(:promotion, start_date: Date.today, end_date: Date.today)
        
        promotion.valid?
        
        expect(promotion.errors.include? :start_date).to be true
        expect(promotion.errors[:start_date]).to include(' e data final não podem ser iguais.')
      end

      it 'data final não pode ser anterior à data inicial' do
        promotion = build(:promotion, start_date: Date.today, end_date: 2.day.ago)
        
        promotion.valid?

        expect(promotion.errors.include? :end_date).to be true
        expect(promotion.errors[:end_date]).to include(' não pode ser anterior à data inicial.')
      end
    end
  end
 end
