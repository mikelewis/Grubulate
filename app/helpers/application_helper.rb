module ApplicationHelper
  def setup_user(user)
    user.tap do |u|
      u.build_profile if u.profile.nil?
    end
  end
end
