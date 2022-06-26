class ProductItemsController < ApplicationController
  before_action :set_customer
  before_action :authenticate_customer!

  def index
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)
    @rate = RateApiConsumerService.rate_api_consumer
    @total_value = sum_total / @rate
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

  def sum_quantity
    @item = ProductItem.find(params[:id])
    customer = @item.customer_id
    @item.quantity += 1
    @item.save

    redirect_to customer_product_items_path(customer), notice: 'Unidade adicionada com sucesso'
  end

  def reduce_quantity
    @item = ProductItem.find(params[:id])
    customer = @item.customer_id
    @item.quantity -= 1
    @item.save

    redirect_to customer_product_items_path(customer), notice: 'Unidade removida com sucesso'
  end

  def remove_all
    @shopping_cart = ProductItem.where(customer_id: current_customer.id)
    @shopping_cart.each do |item|
      item.destroy
    end

    redirect_to customer_product_items_path(current_customer.id)
  end

  def sum_total
    shopping_cart = ProductItem.where(customer_id: current_customer.id)
    total_value = 0
    shopping_cart.each do |p|
      total_value += p.calculate_total_product_values
    end
    total_value
  end

  private

  def set_customer
    @customer_id = params[:customer_id]
  end
end
