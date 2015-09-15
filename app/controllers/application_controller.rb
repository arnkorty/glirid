class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout

  before_action :authenticate_account!

  protected
  def set_layout
    if devise_controller? && !account_signed_in?
      'devise'
    else
      'application'
    end
  end
end