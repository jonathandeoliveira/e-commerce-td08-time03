class ProductPricesController < ApplicationController
  before_action :authenticate_merchant!, only: %i[new create edit update]
  before_action :set_product_model, only: %i[new create edit update]

  def new
    @price = ProductPrice.new
  end

  def create    
    @price = ProductPrice.new(price_params)
    @price.product_model = @product_model
    if @price.save
      redirect_to product_model_path(@product_model), notice: "Preço cadastrado com sucesso."
    else
      flash.now[:alert] = 'Preço não pode ser cadastrado.'
      render :new
    end
  end

  def edit
    @price = ProductPrice.find(params[:id])
  end

  def update
    @price = ProductPrice.find(params[:id])
    if @price.update(price_params)
      redirect_to product_model_path(@product_model), notice: 'Edição de preço realizada com sucesso'
    else
      flash.now[:notice] = 'Falha ao atualizar preço do produto.'
      render 'edit'
    end
  end

  private

  def price_params
    my_params = params.require(:product_price).permit(:price, :start_date, :end_date, :product_model_id)
  end

  def set_product_model
    @product_model = ProductModel.find(params[:product_model_id])
  end
end
