class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user_sign_in
    if (params[:controller] == "user/reservations") && (params[:action] == "new") && !user_signed_in?
      flash[:alert] = "Please log in or sign up to continue with your booking!"
      redirect_to log_in_path
    elsif !user_signed_in?
      redirect_page_not_found
    end
  end

  def redirect_page_not_found
    flash[:alert] = "Page not found!"
    render :file => 'public/404.html', :status => :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end

end
