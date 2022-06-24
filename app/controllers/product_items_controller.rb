class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!

  def index
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)
    @rate = get_api_ruby_value
  end

  def create
    product_model_id = params[:product_model_id]
    quantity = params[:quantity]
    product_model = ProductModel.find(params[:product_model_id])
    ProductItem.create!(product_model: product_model, quantity: quantity, customer_id: @customer_id)

    redirect_to customer_product_items_path(product_model_id), notice: "#{product_model.name} adicionado ao carrinho."
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
end
