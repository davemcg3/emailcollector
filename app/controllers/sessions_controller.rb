class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user.present? && user.authenticate(params[:password])
      logger.info("Logged in as #{user.name}")

      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}"
      redirect_to '/'
    else
      logger.info("Failed to login as #{params[:email]}")
      # If user's login doesn't work, send them back to the login form.
      flash[:danger] = "Unable to login"
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:warning] = 'Logged out'
    redirect_to '/'
  end

end
