class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  @debug = nil

  def current_user
    Rails.logger.debug "3"
    Rails.logger.debug @current_user
    Rails.logger.debug session[:user_id]
    Rails.logger.debug User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    Rails.logger.debug "authorizing"
    redirect_to '/' unless current_user
  end

  def is_admin
    Rails.logger.debug "is_admin"
    Rails.logger.debug current_user
    Rails.logger.debug current_user.admin
  	if not current_user.admin
      Rails.logger.debug "Unauthorized redirecting to /"
  		flash[:danger] = 'Unauthorized'
  		redirect_to '/'
  	end
  end

end
