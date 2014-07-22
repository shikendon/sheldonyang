class User
  module OmniauthCallbacks
    def find_or_create_by_oauth(auth, signed_in_resource = nil)
      authorization = Authorization.find_by_oauth(auth)
      return authorization.user if authorization && authorization.user

      provider = auth.provider
      uid = auth.uid
      name = auth.info.name || auth.info.nickname
      email = auth.info.email || "#{provider}.#{uid}@sheldonyang.herokuapp.com"

      user = User.find_or_create_by!(email: email)
      user.update_attributes!(password: Devise.friendly_token[0,20],
                              name: name)

      authorization = Authorization.find_or_create_by!(provider: provider , uid: uid)
      authorization.update_attributes!(user_id: user.id)

      return user
    end
  end
end
