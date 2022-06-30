class CustomerCreditService
  def self.retrieve_credit(customer)
    registration_number = customer.registration_number
    json_data = {
      client: { registration_number: }
    }.to_json

    response = Faraday.post('http://localhost:4000/api/v1/clients/balance', json_data, content_type: 'application/json')
    if response.status == 200
      response_body = JSON.parse(response.body)
      response_body['client']['balance_rubi'].to_d
    else
      0
    end
  rescue Faraday::ConnectionFailed
    nil
  end
end
