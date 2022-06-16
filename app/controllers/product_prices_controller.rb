class ProductPricesController < ApplicationController  
  def new
    @product_model = ProductModel.find(params[:product_model_id])
    @price = ProductPrice.new
  end

  def create    
    @product_model = ProductModel.find(params[:product_model_id])
    @price = ProductPrice.new(price_params)
    @price.product_model = @product_model
    if @price.save
      redirect_to product_model_path(@product_model), notice: "Preço cadastrado com sucesso."
    end
  end

  private

  def price_params
    my_params = params.require(:product_price).permit(:price, :start_date, :end_date, :product_model_id)
  end
end
