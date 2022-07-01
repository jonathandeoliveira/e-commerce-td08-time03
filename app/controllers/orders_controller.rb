class OrdersController < ApplicationController
  before_action :set_user
  before_action :authenticate_merchant!, only: %i[merchant_index merchant_show]
  before_action :set_customer, except: %i[merchant_index merchant_show]

  def index
    @shopping_cart = ProductItem.where(customer_id: @customer)
    @orders = Order.where(customer_id: @customer) if customer_signed_in?
  end

  def new
    @promotion = Promotion.where(status: :active)
    @shopping_cart = ProductItem.where(customer_id: @customer, order_id: nil)
    @order = Order.new
    
  end


  def create
    rate = RateApiConsumerService.rate_api_consumer
    address = current_customer.full_adress
    @order = Order.new(customer_id: @customer, total_value: calculate_total_value_cart, address:, rate:)
    if @valid_promotion.present?
      @order_cupom
      @order.promotion = @valid_promotion.code
    end
    if current_customer.balance > @order.total_value
      if @order.save!
        OrderDataService.send_order(@order)
        redirect_to customer_orders_path(@customer), notice: 'Compra realizada com sucesso'
      else
        flash.now[:notice] = 'Falha ao criar pedido'
        render 'new'
      end
    else
      redirect_to customer_rubi_buy_path(@customer),
                  notice: 'Saldo insuficiente, por favor realize a compra de créditos em Rubis para finalizar o procedimento'
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

  def search_coupon    
    @shopping_cart = ProductItem.where(customer_id: @customer, order_id: nil)    
    @coupon = params[:coupon]
    @customer = current_customer
    @promotion = Promotion.find_by(code: @coupon)
    @order_cupom = Order.new
    if @promotion.present?
      valid_promotion = @promotion.check_promotion_validation
      if valid_promotion.active?  
        flash[:notice] = 'Cupom adicionado com sucesso'        
        redirect_to customer_order_with_coupon_path(@customer)    
        @order_cupom.promotion = valid_promotion.code
        @discount = calculate_discount
        @discount = verify_discount_value
        #binding.pry
      end
    end
  end

  def order_with_coupon
    @customer = current_customer
    @shopping_cart = ProductItem.where(customer_id: @customer, order_id: nil)
    @coupon = params[:coupon]
    @promotion = Promotion.find_by(code: @coupon)
    binding.pry
  end

  def send_cupom_params
    binding.pry
  end


  def calculate_discount
    @discount = 0
    @shopping_cart.each do |product|
      if @promotion.sub_categories.include?(product.product_model.sub_category) 
        value = ((product.product_model.current_price * ((@promotion.discount_percent).to_f/100)) * product.quantity)
        @discount += BigDecimal(value)
      end
    end
    @discount
  end

  def verify_discount_value
    if @discount > @promotion.max_discount_money
      @promotion.max_discount_money
    else
      @discount
    end
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

  def total_with_descount
    @discount = calculate_total_value_cart - BigDecimal(total_discount)
  end

  def set_customer
    @customer = params[:customer_id]
  end
end
