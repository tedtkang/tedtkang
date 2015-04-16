class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to posts_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        ### This is all extra shit.  Just redirect to main posts page now.
        redirect_back_or posts_path 
      #else
      #  message  = "Account not activated. "
      #  message += "Check your email for the activation link."
      #  flash[:warning] = message
      #  redirect_to root_url
      #end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
