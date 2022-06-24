class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!

  def index
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)   
    @rate = get_api_ruby_value
  end  

  private

  def set_customer
    @customer_id = params[:customer_id]
  end
end

