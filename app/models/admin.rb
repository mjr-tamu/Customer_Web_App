class Admin < ApplicationRecord

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # Find existing admin by email (case insensitive) or create new one
    admin = find_by('LOWER(email) = LOWER(?)', email)
    if admin
      # Update existing admin with new OAuth data
      admin.update!(uid: uid, full_name: full_name, avatar_url: avatar_url)
      admin
    else
      # Create new admin
      create!(email: email, uid: uid, full_name: full_name, avatar_url: avatar_url, encrypted_password: 'oauth_user')
    end
  end

end
