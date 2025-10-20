class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # The passthru method is required by Devise for OAuth initiation
    # We inherit it from the parent controller, but we need to make sure it's available
    
    def google_oauth2
      user = User.from_google(**from_google_params)
  
      if user.present?
        sign_out_all_scopes
        if user.admin?
          flash[:success] = "Welcome back, #{user.full_name}! You're signed in as an admin."
        else
          flash[:success] = "Welcome back, #{user.full_name}! You're signed in as a member."
        end
        sign_in_and_redirect user, event: :authentication
      else
        flash[:error] = "Authentication failed. Please try again."
        redirect_to new_user_session_path
      end
    end
  
    protected
  
    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
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
