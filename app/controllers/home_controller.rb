class HomeController < ApplicationController
  before_action @tax = :get_api_ruby_value
  def index
    @products = ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ', DateTime.now, DateTime.now)
  end
end
