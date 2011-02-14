class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(method, *args)
    @provider = method.to_s.downcase
    raise "Unknown Provider Method: #{method}" unless @provider =~ /facebook/
    @omniauth = request.env['omniauth.auth']
    auth = Authentication.where(:provider => @omniauth['provider'], :uid => @omniauth['uid']).first
    @user = User.find(auth.user_id) if auth

    if @user
      sign_in_and_redirect(:user, @user)

    elsif current_user
      current_user.authentications.create(:provider => @omniauth['provider'], :uid => @omniauth['uid'])
      redirect_to(redirect_location(:user, current_user))
    else
      email = user_email
      @user = User.new(:email => email , :password => Devise.friendly_token[0,20])
      @user.build_profile(:username => email.split('@')[0].gsub(/[^^0-9A-Za-z_]/, ''))
      @user.authentications.build(:provider => @omniauth['provider'], :uid => @omniauth['uid'])
      @user.save!
      @user.profile.url_to_image(profile_image, true)
      sign_in_and_redirect(:user, @user)
    end
  end

  private
  def user_email
    if @provider == "facebook"
      return @omniauth['extra']['user_hash']['email']
    end
  end
  def profile_image
    if @provider == "facebook"
      return "http://graph.facebook.com/#{@omniauth['extra']['user_hash']['id']}/picture?type=large"
    end
  end
end

