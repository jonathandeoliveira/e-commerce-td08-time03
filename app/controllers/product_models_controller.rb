class ProductModelsController < ApplicationController
  before_action :authenticate_merchant!

  def new
    @product_model = ProductModel.new()
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Produto cadastrado com sucesso'
    else
      render 'new'
   end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def index
    @product_models = ProductModel.all
  end


  private

  def product_model_params
    params.require(:product_model).permit(:name, :brand, :sku, :model, :fragile,
                        :description, :weight, :height, :width, :length)
  end


end
