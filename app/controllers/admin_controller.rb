class AdminController < ApplicationController
  before_action :require_login

  private

  def require_login
    # This looks for a user_id in the session cookie
    unless Current.user
      redirect_to new_session_path, alert: "You must be signed in to access this section."
    end
  end
end