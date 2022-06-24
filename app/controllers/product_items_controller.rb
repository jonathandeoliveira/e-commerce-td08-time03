class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!

  def index
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)   
    @rate = get_api_ruby_value
  end  

  def destroy
    product_to_remove = ProductItem.find(params[:id])
    customer_id = product_to_remove.customer_id

    product_to_remove.destroy

    redirect_to customer_product_items_path(customer_id), notice: "Item removido com sucesso."
  end

  private

  def set_customer
    @customer_id = params[:customer_id]
  end
end

