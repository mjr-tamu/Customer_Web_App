# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Require authentication for all controllers by default
  before_action :authenticate_admin!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Override Devise's authentication redirect
  def after_sign_in_path_for(resource_or_scope)
    home_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Helper method to check if a regular user is signed in
  def user_signed_in?
    session[:user_info]&.dig("signed_in") == true
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
