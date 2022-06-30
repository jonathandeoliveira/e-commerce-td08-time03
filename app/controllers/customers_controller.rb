class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  before_action :update_customer_balance
  before_action :check_customer, only: :account

  def account; end

  def update_customer_balance
    @customer.balance = consumed_balance
    @customer.save!
  end

  def check_customer
    @customer = Customer.find(params[:id])
    redirect_to root_path, alert: 'Erro! Página não encontrada :(' if @customer != current_customer
  end

  private

  def consumed_balance
    CustomerCreditService.retrieve_credit(@customer)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
