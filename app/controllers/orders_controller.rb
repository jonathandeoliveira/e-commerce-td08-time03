class OrdersController < ApplicationController
  before_action :set_customer

  def new
    @shopping_cart = ProductItem.where(customer_id: @customer)
    @order = Order.new
  end

  def index
    @shopping_cart = ProductItem.where(customer_id: @customer)
    @orders = Order.all
  end

  def create
    total = 10
    product_items = ProductItem.where(customer_id: @customer)
    @order = Order.new(customer_id: @customer, total_value: calculate_total_value_cart)
    if @order.save!
      redirect_to customer_orders_path(@customer), notice: 'Pedido realizado com sucesso'
    else
      flash.now[:notice] = 'Algo deu errado'      
    end    
  end
  
  def show
    @order = Order.find(params[:id])
    @product_items = ProductItem.where(order_id: @order)
  end

  def calculate_total_value_cart
    total = 0
    customer = Customer.find(@customer)
    customer.product_items.each do |product_value|
      total += product_value.calculate_total_product_values
    end
    total
  end

  private
  def set_customer
    @customer = params[:customer_id]
  end
end