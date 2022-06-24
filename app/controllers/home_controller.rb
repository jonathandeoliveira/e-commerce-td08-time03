class HomeController < ApplicationController
  def index
    @rate = get_api_ruby_value
    @products = ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ', DateTime.now, DateTime.now)
  end
end
