class SessionsController < ApplicationController

  def new
  end

  def create
    Rails.logger.debug params[:email]
    user = User.find_by_email(params[:email])
    Rails.logger.debug user
    Rails.logger.debug user.authenticate(params[:password])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      Rails.logger.debug("Logged in as #{user.name}")

      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}"
      redirect_to '/'
    else
      Rails.logger.debug("Failed to login as #{params[:email]}")
      # If user's login doesn't work, send them back to the login form.
      flash[:danger] = "Unable to login"
      redirect_to '/login'
    end
  end

  def destroy
    Rails.logger.debug("Logged out")
    #session[:user_id] = nil
    session.delete(:user_id)
    flash[:warning] = 'Logged out'
    redirect_to '/'
  end

end
