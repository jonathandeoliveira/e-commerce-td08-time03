class PromotionsController < ApplicationController
  before_action :authenticate_merchant!, except: %i[search_coupon]

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])    
  end

  def new
    @sub_categories = SubCategory.all
    @promotion = Promotion.new
  end

  def create
    @sub_categories = SubCategory.all
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to  promotion_path(@promotion), notice: "Promoção cadastrada com sucesso"
    else 
      flash.now[:alert] ='Erro! Não foi possível cadastrar nova promoção :('
      render 'new'
    end
  end

  def search_coupon
    coupon = params[:coupon]
    @customer = current_customer    
    @promotion = Promotion.find_by(code: coupon)
    if @promotion.present?
      @promotion.check_promotion_validation
      if @promotion.inactive?
        @shopping_cart = ProductItem.where(customer_id: @customer.id, order_id: nil)
        address = current_customer.full_adress
        @order = Order.new(customer_id: @customer.id, total_value: calculate_total_value_cart, address: address)
        flash.now[:alert] = 'Cupom inválido'
        return render 'orders/new' 
      elsif @promotion.active?
        @shopping_cart = ProductItem.where(customer_id: @customer.id, order_id: nil)
        address = current_customer.full_adress
        @order = Order.new(customer_id: @customer.id, total_value: (calculate_total_value_cart - total_discount), address: address)
        flash.now[:notice] = 'Cupom aplicado com sucesso'
        return render 'orders/new'
      end
    end
  end



  private

  def calculate_total_value_cart
    total = 0
    customer = current_customer
    products = customer.product_items.where(order_id: nil)
    products.each do |product_value|
      total += product_value.calculate_total_product_values
    end
    total
  end

  def total_discount
    discount = []
    @shopping_cart.each do |product|
      if @promotion.sub_categories.include?(product.product_model.sub_category) 
        #product.product_model.current_price =product.product_model.current_price + product.product_model.current_price * ((@promotion.discount_percent).to_f)/100
        value = ((product.product_model.current_price * ((@promotion.discount_percent).to_f/100)) * product.quantity)
        discount << [value.to_f]
      end
      discount = discount.sum
      if discount > @promotion.max_discount_money
        discount = @promotion.max_discount_money
      else
        discount.to_d
      end
    end
  end

  

  def promotion_params
    params.require(:promotion).permit(:name,:code,:start_date,:end_date,:max_quantity, :discount_percent, :max_discount_money, :sub_category_ids => [])
  end
end