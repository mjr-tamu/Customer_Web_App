class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :calendars, dependent: :destroy

  validates :role, inclusion: { in: %w[member admin] }
  validates :email, presence: true, uniqueness: true

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # Find existing user or create new one
    user = find_by('LOWER(email) = LOWER(?)', email)
    
    if user
      # Update existing user with new OAuth data
      user.update!(uid: uid, full_name: full_name, avatar_url: avatar_url)
      user
    else
      # Create new user as member by default
      create!(
        email: email,
        full_name: full_name,
        uid: uid,
        avatar_url: avatar_url,
        role: 'member'
      )
    end
  end
end
