class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?
  
  def login(user)
    debugger
    session[:session_token] = user.reset_session_token
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    debugger
    !!current_user
  end  
  
  def require_login
    redirect_to new_session_url unless logged_in?
  end
  
  def logout
    current_user.reset_session_token
    session[:session_token] = nil
    @current_user = nil 
    redirect_to new_session_url
  end
end
