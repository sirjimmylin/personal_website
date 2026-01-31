class ApplicationController < ActionController::Base
  # Make the authenticated? method available to views (.erb files)
  helper_method :authenticated?

  before_action :set_current_user

  private

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  # Define what "authenticated?" actually means
  def authenticated?
    Current.user.present?
  end
end