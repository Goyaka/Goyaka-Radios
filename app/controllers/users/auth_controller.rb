class Users::AuthController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  
  def after_omniauth_failure_path_for(scope)
    root_path
  end
    
  # The basic primary provider - the openid based on gmail apps login
  def facebook
    omniauth = request.env["omniauth.auth"]
    user = User.find_or_create_from_omniauth(omniauth)
    sign_in_and_redirect user, :event => :authentication
  end
  
end
