class ProductModelsController < ApplicationController
  before_action :authenticate_merchant!, only: %i[new create show update disable enable index]
  

  def product_detail
    @product_model = ProductModel.find(params[:id])
    @product_price = ProductPrice.where('product_model_id = ? and start_date <= ? AND end_date >= ? ',@product_model.id ,DateTime.now, DateTime.now).first
    if @product_model.disabled?
      redirect_to root_path, alert: 'Erro! Página não encontrada :('
    end
  end

  def new
    @product_model = ProductModel.new
    @subcategories = SubCategory.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Produto cadastrado com sucesso'
    else
      @subcategories = SubCategory.all
      render 'new'
   end
  end

  def show
    @product_model = ProductModel.find(params[:id])
    @prices = ProductPrice.where(product_model: @product_model)   
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
    prices = @product.product_prices.to_a
    total_days = 0
    prices.each do |price|
      total_days+= price.end_date - price.start_date
    end
    if total_days >= 90
      if @product.enabled!
        redirect_to product_models_path, notice: 'Produto ativado com sucesso'
      end
    else
      flash[:notice] = "Produto com #{total_days.round} dias cadastrados"
      redirect_to product_models_path, alert: 'Produto não pode ser ativado: Necessário mínimo de 90 dias de preços cadastrados.' 
    end
  end


  def search
    @query = params["query"]
    @product_models = ProductModel.where("name LIKE ?", "%#{@query}%").where(status: :enabled)
  end


  private

  def product_model_params
    params.require(:product_model).permit(:name, :brand, :sku, :model, :fragile,
                        :description, :weight, :height, :width, :length, :status, :sub_category_id, :manual)
  end
end