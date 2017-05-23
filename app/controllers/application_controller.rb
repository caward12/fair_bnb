class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user_sign_in
    if !user_signed_in?
      flash[:alert] = "Page not found!"
      render :file => 'public/404.html', :status => :not_found
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end


  # helper_method :current_user
  #
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  #
  # def current_user=(user)
  #   @current_user = user
  #   session[:user_id] = user.nil? ? nil : user.id
  # end

end
