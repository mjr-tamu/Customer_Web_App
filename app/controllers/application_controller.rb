# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Require authentication for all controllers by default
  before_action :authenticate_admin!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
