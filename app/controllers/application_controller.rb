# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Require authentication for all controllers by default
  before_action :authenticate_admin!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Helper method to check if a regular user is signed in
  def user_signed_in?
    session[:user_info]&.dig(:signed_in) == true
  end
  helper_method :user_signed_in?

  # Helper method to get current user info
  def current_user
    session[:user_info] if user_signed_in?
  end
  helper_method :current_user

  # Helper method to sign out regular user
  def sign_out_user
    session.delete(:user_info)
  end
  helper_method :sign_out_user
end
