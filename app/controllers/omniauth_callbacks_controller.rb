class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.genarate_provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_or_create_by_oauth(env['omniauth.auth'], current_user)

        return if not @user.persisted?
        sign_in_and_redirect(@user, event: :authentication)
        set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?
      end
    }
  end

  [:github, :twitter, :facebook, :google_oauth2, :yahoo].each do |provider|
    genarate_provides_callback_for(provider)
  end
end
