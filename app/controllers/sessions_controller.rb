class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to admin_root_path, notice: "Welcome back!"
    else
      redirect_to login_path, alert: "Invalid credentials"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out."
  end
end
