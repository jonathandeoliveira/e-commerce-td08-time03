class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!

  def index
    @shopping_cart = ProductItem.where(customer_id: @current_customer.id)
  end

  private

  def set_customer
    @customer_id = params[:customer_id]
  end
end
