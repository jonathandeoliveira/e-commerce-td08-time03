class HomeController < ApplicationController
  def index
    @products = ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ',DateTime.now, DateTime.now)
  end
end
