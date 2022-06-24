class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!
  before_action :api_retrieve_rubi_value

  def index
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)
  end

  def create
    quantity = params[:quantity]
    product_model = ProductModel.find(params[:product_model_id])

    return redirect_to product_detail_product_model_path(product_model.id), notice: 'A quantidade deve ser maior do que 0' if quantity.to_i < 1

    ProductItem.create(product_model:, quantity:, customer_id: @customer_id)
    redirect_to customer_product_items_path(product_model.id), notice: "#{product_model.name} adicionado ao carrinho."
  end

  def destroy
    product_to_remove = ProductItem.find(params[:id])
    customer_id = product_to_remove.customer_id

    product_to_remove.destroy

    redirect_to customer_product_items_path(customer_id), notice: 'Item removido com sucesso.'
  end

  private

  def set_customer
    @customer_id = params[:customer_id]
  end

  def api_retrieve_rubi_value
    response = Faraday.get('http://localhost:4000/api/v1/exchange_rates/current')
    @rate = JSON.parse(response.body)["exchange_rate"]["value"].to_d
  end
end
