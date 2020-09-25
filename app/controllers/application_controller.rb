# frozen_string_literal: true

# Provides helper methods used throughout the application
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  @debug = nil

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/' unless current_user
  end

  def admin?
    return if current_user.admin

    flash[:danger] = 'Unauthorized'
    redirect_to '/'
  end
end
