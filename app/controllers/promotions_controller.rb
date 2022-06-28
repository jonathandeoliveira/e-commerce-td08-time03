class PromotionsController < ApplicationController
  before_action :authenticate_merchant!

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])    
  end

end