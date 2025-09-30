class Admin < ApplicationRecord

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # Only authenticate existing admins - do not create new ones
    admin = find_by('LOWER(email) = LOWER(?)', email)
    if admin
      # Update existing admin with new OAuth data
      admin.update!(uid: uid, full_name: full_name, avatar_url: avatar_url)
      admin
    else
      # Return nil for non-admin users
      nil
    end
  end

end
