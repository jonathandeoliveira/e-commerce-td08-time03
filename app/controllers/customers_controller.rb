class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: :account
  before_action :check_customer, only: :account

  def account; end

  def check_customer
    @customer = Customer.find(params[:id])
    redirect_to root_path, alert: "Erro! Página não encontrada :(" if @customer != current_customer
  end
end