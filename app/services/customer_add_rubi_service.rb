class CustomerAddRubiService
  def self.add_credit(customer, real_amount)
    json_data = {
      client: { registration_number: customer.registration_number, real_amount: real_amount }
    }.to_json

    response = Faraday.post('http://localhost:4000/api/v1/clients/credit', json_data,
                            content_type: 'application/json')
    if response.status == 200
      response_body = JSON.parse(response.body)
      response_body['credit']['rubi_amount'].to_d
    else
      0
    end
  rescue Faraday::ConnectionFailed
    nil
  end
end
