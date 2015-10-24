class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def admin_required
    if !user_signed_in? || !current_user.is_admin?
      redirect_to root_url
    end
  end
end
