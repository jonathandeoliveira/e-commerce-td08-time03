class PromotionsController < ApplicationController
  before_action :authenticate_merchant!

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])    
  end

  def new
    @sub_categories = SubCategory.all
    @promotion = Promotion.new
  end

  def create
    @sub_categories = SubCategory.all
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to  promotion_path(@promotion), notice: "Promoção cadastrada com sucesso"
    else 
      flash.now[:alert] ='Erro! Não foi possível cadastrar nova promoção :('
      render 'new'
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name,:code,:start_date,:end_date,:max_quantity, :discount_percent, :max_discount_money, :sub_category_ids => [])
  end
end