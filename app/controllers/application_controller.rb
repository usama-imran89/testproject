class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[ :fname, :lname,:dname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys:[ :fname, :lname,:dname, :email, :password, :current_password])

  end
  def initialize_session
    session[:cart] ||=Hash.new
  end
  def load_cart
    @cart =Item.find(session[:cart].keys)
  end
end
