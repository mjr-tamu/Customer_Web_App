class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    admin = Admin.from_google(**from_google_params)

    if admin.present?
      sign_out_all_scopes
      if admin.admin?
        flash[:success] = "Welcome back, #{admin.full_name}! You're signed in as an admin."
      else
        flash[:success] = "Welcome #{admin.full_name}! You're signed in as a member."
      end
      sign_in_and_redirect admin, event: :authentication
    else
      # This should not happen anymore since we create users automatically
      flash[:error] = "Authentication failed. Please try again."
      redirect_to new_admin_session_path
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || home_path
  end

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

end
