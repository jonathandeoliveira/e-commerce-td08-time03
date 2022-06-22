class HomeController < ApplicationController
  def index
    @products = ProductModel.where(status: :enabled)
    # @products.each do |p|
    #  p.atualiza_preco!
    #end
    #@prices = ProductPrice.where("start_date ==#{Date.today}")
    #puts @prices
  end
end


