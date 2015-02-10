class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_sesion_path, alert: "Please sign in!"
    end
  end
  def user_signed_in? #this is only accessible in the controller
    session[:user_id].present?
  end
  def current_user

  end

  helper_method :user_signed_in? #make it accessible in the Views, 
end
