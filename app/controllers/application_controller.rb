class ApplicationController < ActionController::Base
  protect_from_forgery
  uses_tiny_mce

  helper_method :current_user
  #helper_method :require_login

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user then
    else
      redirect_to root_url, :notice=>"login required!"
    end
  end
end
