require 'rails_helper'

RSpec.describe ProductPrice, type: :model do
  describe '#valid?' do
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:end_date)}
    it {should validate_numericality_of(:price).is_greater_than(0)}
    
    it 'data inicial não pode ser passada' do
      price = build(:product_price, start_date: 1.day.ago)
      
      price.valid?

      expect(price.errors.include? :start_date).to be true
      expect(price.errors[:start_date]).to include(' não pode ser no passado.')
    end

    it 'data final não pode ser passada' do
      price = build(:product_price, start_date: Date.today, end_date: 1.day.ago)
      
      price.valid?

      expect(price.errors.include? :end_date).to be true
      expect(price.errors[:end_date]).to include(' não pode ser no passado.')
    end

    it 'data inicial não pode ser igual a data final' do
      price = build(:product_price, start_date: Date.today, end_date: Date.today)
      
      price.valid?
      
      expect(price.errors.include? :start_date).to be true
      expect(price.errors[:start_date]).to include(' e data final não podem ser iguais.')
    end

    it 'data final não pode ser anterior à data inicial' do
      price = build(:product_price, start_date: Date.today, end_date: 1.day.ago)
      
      price.valid?

      expect(price.errors.include? :end_date).to be true
      expect(price.errors[:end_date]).to include(' não pode ser anterior à data inicial.')
    end

    it 'não pode haver preço cadastrado em intervalo de datas já existente' do
      product = create(:product_model)
      first_price = create(:product_price, start_date: Date.today, end_date: 10.day.from_now, product_model: product)
      second_price = build(:product_price, start_date: 8.day.from_now, end_date: 20.day.from_now, product_model: product)
      third_price = build(:product_price, start_date: 11.day.from_now, end_date: 21.day.from_now, product_model: product)

      second_price.valid?
      third_price.valid?
      
      expect(second_price.errors.include? :price).to be true
      expect(third_price.errors.include? :price).to be false
      expect(second_price.errors[:price]).to include(' não pode ser cadastrado, pois está incluso em intervalo de datas já existentes')
      expect(third_price.errors[:price]).not_to include(' não pode ser cadastrado, pois está incluso em intervalo de datas já existentes')
    end
  end
end
