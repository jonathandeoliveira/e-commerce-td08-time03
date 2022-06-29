require 'rails_helper'

# describe 'Order API' do
#   context 'POST /api/v1/orders' do
#     it 'com sucesso' do
#       customer = create(:customer)
#       rate = RateApiConsumerService.rate_api_consumer
#       order = create(:order, customer: customer, address: customer.full_adress)
#       order_params = { order: { id: order.id, code: order.code, customer: customer.name, total_value: order.total_value } }

#       post '/api/v1/orders', params: order_params
#       json_response = JSON.parse(response.body)

#       expect(response).to have_http_status 200
#       expect(response.content_type).to include 'application/json'
#       expect(json_response['order']['customer']).to eq(customer.name)
#       expect(json_response['order']['total_value']).to eq(order.total_value)
#     end
#   end
# end