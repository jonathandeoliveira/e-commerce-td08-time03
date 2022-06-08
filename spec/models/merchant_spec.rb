require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '#valid?' do
    context 'domínio de email' do
      it 'domínio de email deve ser @mercadores.com.br' do
        merchant = Merchant.new(email: 'paulo@hotmail.com')
        merchant.valid?
        result = merchant.errors.include?(:email)
        expect(result).to be true
        
        
      end

    end
  end
end
