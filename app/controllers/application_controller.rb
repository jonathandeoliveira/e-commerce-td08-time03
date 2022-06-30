class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :full_adress, :registration_number])
  end

  def set_user
    customer_signed_in? ? authenticate_customer! : authenticate_merchant!
  end
end
