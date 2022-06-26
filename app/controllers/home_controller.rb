class HomeController < ApplicationController
  def index
    @products = ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ',DateTime.now, DateTime.now)
    @categories = Category.all
    @subcategories = SubCategory.all
    @rate = RateApiConsumerService.rate_api_consumer
  end
end
