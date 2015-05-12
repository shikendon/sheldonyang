class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def omniauth_provider
    provider_name = __callee__.to_s.capitalize
    @user = User.find_or_create_by_oauth(env['omniauth.auth'], current_user)
    return if not @user.persisted?
    sign_in_and_redirect(@user, event: :authentication)
    set_flash_message(:notice, :success, kind: provider_name) if is_navigational_format?
  end

  alias_method :github, :omniauth_provider
  alias_method :twitter, :omniauth_provider
  alias_method :facebook, :omniauth_provider
  alias_method :google_oauth2, :omniauth_provider
  alias_method :yahoo, :omniauth_provider

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
