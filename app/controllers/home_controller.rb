class HomeController < ApplicationController
  def index
    @products = ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ',DateTime.now, DateTime.now)
    @categories = Category.all
    @subcategories = SubCategory.all    
    @rate = api_retrieve_rubi_value
  end

  protected
  def api_retrieve_rubi_value
    response = Faraday.get('http://localhost:4000/api/v1/exchange_rates/current')
    JSON.parse(response.body)["exchange_rate"]["value"].to_d
  end
end