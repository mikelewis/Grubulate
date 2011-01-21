class ApplicationController < ActionController::Base
  helper_method :current_profile
  protect_from_forgery

  def current_profile
    current_user.profile if current_user
  end
end
