class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout :set_layout
  protect_from_forgery with: :exception

  before_action :authenticate_account!
  # before_filter :update_sanitized_params, if: :devise_controller?

  protected
  def set_layout
    if devise_controller? && !account_signed_in?
      'devise'
    else
      'application'
    end
  end

  # def update_sanitized_params
  #   devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation)}
  #   devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:email, :password, :password_confirmation)}
  # end
end
