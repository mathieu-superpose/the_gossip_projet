class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def set_user
    redirect_to login_path unless session[:user_id] != nil
  end 
  
end
