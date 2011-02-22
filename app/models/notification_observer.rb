class NotificationObserver < ActiveRecord::Observer
  observe :comment, :recipe
  def after_create(record)
    Notification.add(record)
  end
end

