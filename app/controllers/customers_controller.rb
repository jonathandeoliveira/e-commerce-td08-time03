class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: %i[account]
  before_action :check_customer, only: %i[account]

  def account
   
  end

  def check_customer
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to root_path, alert: "Erro! Página não encontrada :("
    end
  end
end