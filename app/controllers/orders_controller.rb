class OrdersController < ApplicationController
  before_action :set_user
  before_action :authenticate_merchant!, only: %i[merchant_index merchant_show]
  before_action :set_customer, except: %i[merchant_index merchant_show]

  def index
    @shopping_cart = ProductItem.where(customer_id: @customer)
    @orders = Order.where(customer_id: @customer) if customer_signed_in?
  end

  def new
    @shopping_cart = ProductItem.where(customer_id: @customer, order_id: nil)
    @order = Order.new
  end

  def create
    rate = RateApiConsumerService.rate_api_consumer
    address = current_customer.full_adress
    @order = Order.new(customer_id: @customer, total_value: calculate_total_value_cart, address: address, rate: rate)
    if current_customer.balance > @order.total_value
      if @order.save!
        OrderDataService.send_order(@order)
        redirect_to customer_orders_path(@customer), notice: 'Pedido realizado com sucesso'
      else
        flash.now[:notice] = 'Falha ao criar pedido'
        render 'new'
      end
    else
      redirect_to customer_rubi_buy_path(@customer), notice: 'Saldo insuficiente, por favor realize a compra de créditos em Rubis para finalizar o procedimento'
    end
  end

  def show
    @order = Order.find(params[:id])
    @product_items = ProductItem.where(order_id: @order.id)
  end

  def merchant_index
    @orders = Order.all if merchant_signed_in?
  end

  def merchant_show
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

  def calculate_total_order
    total = 0
    order = Order.find(params[:id])
    products = order.customer.product_items
    products.each do |product_value|
      total += product_value.calculate_total_product_values
    end
    total
  end

  def set_customer
    @customer = params[:customer_id]
  end
end
