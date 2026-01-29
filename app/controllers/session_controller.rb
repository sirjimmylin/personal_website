class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
      session[:user_id] = user.id
      redirect_to admin_root_path, notice: "Welcome back!"
    else
      redirect_to login_path, alert: "Invalid credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out."
  end
end