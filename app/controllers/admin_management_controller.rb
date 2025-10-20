class AdminManagementController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @users = User.all.order(:email)
  end

  def create_admin
    email = params[:email]&.strip&.downcase
    
    if email.blank?
      flash[:alert] = "Email cannot be blank."
      redirect_to admin_management_path and return
    end

    # Check if user already exists
    user = User.find_by('LOWER(email) = ?', email)
    
    if user
      if user.admin?
        flash[:alert] = "User with email #{email} is already an admin."
      else
        # Convert member to admin
        user.update!(role: 'admin')
        flash[:success] = "User #{email} has been promoted to admin successfully."
      end
      redirect_to admin_management_path and return
    end

    # Validate email format
    unless email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      flash[:alert] = "Invalid email format."
      redirect_to admin_management_path and return
    end

    # Create new admin user
    begin
      user = User.create!(
        email: email,
        full_name: email.split('@').first.titleize,
        uid: SecureRandom.hex(10),
        role: 'admin',
        encrypted_password: 'pending_oauth'
      )
      flash[:success] = "Admin #{email} has been added successfully."
    rescue => e
      flash[:alert] = "Error creating admin: #{e.message}"
    end

    redirect_to admin_management_path
  end

  def remove_admin
    user = User.find(params[:id])
    
    # Prevent removing the last admin
    if User.where(role: 'admin').count <= 1
      flash[:alert] = "Cannot remove the last admin."
      redirect_to admin_management_path and return
    end

    # Prevent admin from removing themselves
    if user == current_user
      flash[:alert] = "You cannot remove yourself as an admin."
      redirect_to admin_management_path and return
    end

    # Convert admin back to member instead of deleting
    user.update!(role: 'member')
    flash[:success] = "User #{user.email} has been demoted to member successfully."
    redirect_to admin_management_path
  end
end