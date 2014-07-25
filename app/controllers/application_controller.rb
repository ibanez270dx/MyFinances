class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def require_user
    unless current_user
      flash[:notice] = "You have to log in."
      session[:user_id] = nil
      redirect_to login_path and return false
    end
  end
end
