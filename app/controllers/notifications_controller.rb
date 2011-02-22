class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:type] == "all"
      @notifications = current_profile.notifications
    else
      @notifications = current_profile.unseen_notifications
    end
  end

  def destroy
    current_profile.seen_notification(params[:id])
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

end
