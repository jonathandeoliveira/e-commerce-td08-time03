class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, except: %i[send_credit_request rubi_buy]
  before_action :update_customer_balance, except: %i[send_credit_request rubi_buy]
  before_action :check_customer, except: %i[send_credit_request rubi_buy]

  def account; end

  def rubi_buy
    @rate = RateApiConsumerService.rate_api_consumer
  end

  def send_credit_request
    customer = Customer.find(params[:customer_id])
    amount = params[:real_amount]
    balance_to_add = CustomerAddRubiService.add_credit(customer, amount)
    customer.balance += balance_to_add
    customer.save!
    redirect_to account_customer_path(current_customer), notice: 'Solicitação enviada'
  end

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
