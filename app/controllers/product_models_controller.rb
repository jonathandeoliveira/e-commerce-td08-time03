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

  def disable
    @product = ProductModel.find(params[:id])
    if @product.disabled!
      @product.save
      redirect_to product_models_path, notice: 'Produto desativado com sucesso'
    end
  end

  def enable
    @product = ProductModel.find(params[:id])
    if @product.enabled!
      redirect_to product_models_path, notice: 'Produto ativado com sucesso'
    end
  end


  private

  def product_model_params
    params.require(:product_model).permit(:name, :brand, :sku, :model, :fragile,
                        :description, :weight, :height, :width, :length, :status)
  end
end