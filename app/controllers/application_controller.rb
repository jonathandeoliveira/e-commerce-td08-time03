class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :full_adress, :registration_number])
  end

  def set_current_price
    ProductModel.where(status: :enabled).joins(:product_prices).where('start_date <= ? AND end_date >= ? ', DateTime.now, DateTime.now)
  end

end
