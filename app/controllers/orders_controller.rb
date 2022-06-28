class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_customer

  def new
    @shopping_cart = ProductItem.where(customer_id: @customer, order_id: nil)
    @order = Order.new
  end

  def index
    @shopping_cart = ProductItem.where(customer_id: @customer)
    @orders = Order.where(customer_id: @customer) if customer_signed_in? 
    @orders = Order.all if merchant_signed_in?
  end

  def create
    product_items = ProductItem.where(customer_id: @customer, order_id: nil)
    address = current_customer.full_adress
    @order = Order.new(customer_id: @customer, total_value: calculate_total_value_cart, address: address)
    if @order.save!
      redirect_to customer_orders_path(@customer), notice: 'Pedido realizado com sucesso'
    else
      flash.now[:notice] = 'Falha ao criar pedido'
      render 'new'
    end    
  end
  
  def show
    @order = Order.find(params[:id])
    @product_items = ProductItem.where(order_id: @order.id)
  end

  private
  def calculate_total_value_cart
    total = 0
    customer = Customer.find(@customer)
    products = customer.product_items.where(order_id: nil)
    products.each do |product_value|
      total += product_value.calculate_total_product_values
    end
    total
  end

  def set_customer
    @customer = params[:customer_id]
  end
end