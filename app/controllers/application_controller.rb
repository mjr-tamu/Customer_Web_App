# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Require authentication for all controllers by default
  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Helper method to check if current user is admin
  def admin_user?
    current_user&.admin?
  end
  helper_method :admin_user?

  # Helper method to check if current user is member
  def member_user?
    current_user&.member?
  end
  helper_method :member_user?
end
