class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :accessible_to_secret_zone?

  def accessible_to_secret_zone?
    player_signed_in? || admin_signed_in?
  end
end
