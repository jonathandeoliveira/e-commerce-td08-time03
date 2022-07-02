require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should define_enum_for(:status) }
  describe '#valid?' do
    it 'endereço não pode ficar em branco' do
      customer = create(:customer)
      order = Order.create(customer: customer, total_value: 30)
      
      result = order.valid?

      expect(result).to eq false
      expect(order.errors).to include(:address)
    end

    it 'valor total não pode ficar em branco' do
      customer = create(:customer)
      order = Order.create(customer: customer, address: customer.full_adress)
      
      result = order.valid?

      expect(result).to eq false
      expect(order.errors).to include(:total_value)
    end

    it 'código é único' do
      customer = create(:customer)
      first_order = create(:order, customer: customer, address: customer.full_adress)
      second_order = build(:order, customer: customer, address: customer.full_adress)

      second_order.save
      result = second_order.code

      expect(second_order.errors).not_to include(:code)
    end

    it 'código tem 15 caracteres' do
      customer = create(:customer)
      order = create(:order, customer: customer, address: customer.full_adress)

      result = order.code

      expect(result.length).to eq 15
    end
  end
end
