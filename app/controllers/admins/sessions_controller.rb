# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # Where to go after logging out
  def after_sign_out_path_for(_resource_or_scope)
    home_path
  end

  # Where to go after logging in
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || home_path
  end
end
