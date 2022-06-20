require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '#valid?' do
    context 'domínio de email' do
      it 'domínio de email deve ser @mercadores.com.br' do
        first_merchant = build(:merchant, email: 'paulo@hotmail.com')
        second_merchant = build(:merchant)

        first_merchant.valid?
        second_merchant.valid?

        first_result = first_merchant.errors.include?(:email)
        expect(first_result).to be true    
        second_result = second_merchant.errors.include?(:email)
        expect(second_result).to be false
      end

      it 'domínio de email deve ser único' do
        first_merchant = create(:merchant)
        second_merchant = build(:merchant)

        result = second_merchant.valid?

        expect(result).to eq false
        expect(second_merchant.errors.full_messages.include? 'domínio de email domínio de email deve ser único')
      end
    end

    context 'tamanho de input' do
      it 'tamanho de senha deve ser maior ou igual a 6' do
        first_merchant = build(:merchant, password: '1234')
        second_merchant = build(:merchant, password: '123456')
        third_merchant = build(:merchant)

        first_merchant.valid?
        second_merchant.valid?
        third_merchant.valid?
        
        expect(first_merchant.errors.include? :password).to eq true
        expect(first_merchant.errors.full_messages.include? 'Senha deve ter mínimo de 6 caracteres').to eq true         
        expect(second_merchant.errors.include? :password).to eq false
        expect(second_merchant.errors.full_messages.include? 'Senha deve ter mínimo de 6 caracteres').to eq false
        expect(third_merchant.errors.include? :password).to eq false
        expect(third_merchant.errors.full_messages.include? 'Senha deve ter mínimo de 6 caracteres').to eq false
      end
    end
  end
end
