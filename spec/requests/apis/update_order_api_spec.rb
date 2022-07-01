require 'rails_helper'

describe 'Muda status de pedido' do
  context 'api/v1/order/update_status' do
    it 'com sucesso e o pedido existe' do
      customer = create(:customer)
      first_order = create(:order, customer: customer, address: customer.full_adress)
      code = first_order.code
      order_params = {order_code: "#{code}", order_status: 'paid'  }

      patch '/api/v1/orders/update_status', params: order_params

      first_order.reload
      expect(first_order.status).to eq 'paid'
    end

    it 'sem sucesso, pois não existem pedidos com esse código' do
      customer = create(:customer)
      first_order = create(:order, customer: customer, address: customer.full_adress)
      code = first_order.code
      order_params = { order_code: "1", order_status: 'paid' }

      patch '/api/v1/orders/update_status', params: order_params

      first_order.reload
      expect(response).to have_http_status 404
      expect(first_order.status).to_not eq 'paid'
    end

    it 'sem sucesso, pois o status não é válido' do
      customer = create(:customer)
      first_order = create(:order, customer: customer, address: customer.full_adress)
      code = first_order.code
      order_params = { order_code: "#{code}", order_status: 'wrong' } 

      patch '/api/v1/orders/update_status', params: order_params

      first_order.reload
      expect(response).to have_http_status 406
      expect(first_order.status).to eq 'pending'
    end

    it 'sem sucesso, pois os parâmetros estão incorretos' do
      customer = create(:customer)
      first_order = create(:order, customer: customer, address: customer.full_adress)
      code = first_order.code
      order_params = { order_status: 'pending' }

      patch '/api/v1/orders/update_status', params: order_params

      first_order.reload
      expect(response).to have_http_status 406
      expect(first_order.status).to_not eq 'paid'
    end
  end
end
