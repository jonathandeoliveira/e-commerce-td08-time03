module RateApiConsumerService
  def self.rate_api_consumer
    response = Faraday.get('http://localhost:4000/api/v1/exchange_rates/current')
    if response.status == 200
      response_body = JSON.parse(response.body)

      response_body['exchange_rate']['value'].to_d
    else
      raise ArgumentError, 'A API não está disponível'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    0
  end
end
