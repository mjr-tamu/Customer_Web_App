# frozen_string_literal: true

require 'csv'

class CalendarsController < ApplicationController
  before_action :authenticate_admin!, except: [:home, :show, :about, :signup, :cancel_signup, :sign_out_user]
  before_action :authenticate_admin!, only: [:export_attendees]

  def home
    # Handle date parameter for navigation
    if params[:date].present?
      @current_date = Date.parse(params[:date] + "-01")
    else
      @current_date = Date.current
    end
    
    # Get start and end of month
    month_start = @current_date.beginning_of_month
    month_end = @current_date.end_of_month
    
    # Get calendar start (beginning of week containing month start)
    calendar_start = month_start.beginning_of_week(:sunday)
    calendar_end = month_end.end_of_week(:sunday)
    
    # Get all events for the visible calendar period
    @events = Calendar.where(event_date: calendar_start..calendar_end)
    
    # Apply category filtering
    @selected_categories = params[:categories] || []
    if @selected_categories.present? && @selected_categories.any?(&:present?)
      @events = @events.where(category: @selected_categories)
    end
    
    # Build calendar days array
    @calendar_days = []
    current_date = calendar_start
    
    while current_date <= calendar_end
      day_events = @events.select { |event| event.event_date.to_date == current_date }
      
      @calendar_days << {
        date: current_date,
        events: day_events,
        other_month: current_date.month != @current_date.month,
        today: current_date == Date.current
      }
      
      current_date += 1.day
    end
    
    # Available categories for filtering
    @available_categories = %w[Service Bush\ School Social]
    
    # Load user signups for dashboard (if user is signed in)
    if user_signed_in?
      @user_signups = EventSignup.for_user(current_user["email"]).upcoming.includes(:calendar).order('calendars.event_date ASC')
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def about
    # About page action - no authentication required
  end

  #----------------------------------------------------------------------------#
  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(calendar_params)
    
    if @calendar.save
      flash[:notice] = 'Calendar Event Added!'
      redirect_to home_path
    else
      flash[:notice] = 'One or more fields not filled. Try again!'
      redirect_to new_calendar_url
    end
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  def edit
    @calendar = Calendar.find(params[:id])
  end

  def update
    @calendar = Calendar.find(params[:id])
    
    if @calendar.update(calendar_params)
      flash[:notice] = 'Calendar event updated.'
      redirect_to home_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  def delete
    @calendar = Calendar.find(params[:id])
  end

  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy
    flash[:notice] = 'Calendar event deleted successfully!'
    redirect_to home_path
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  def sign_out_user
    session.delete(:user_info)
    flash[:notice] = "You have been signed out successfully."
    redirect_to root_path
  end

  def signup
    @calendar = Calendar.find(params[:id])
    
    unless user_signed_in?
      flash[:alert] = "Please sign in to register for events."
      redirect_to root_path
      return
    end
    
    # Check if user already signed up
    if @calendar.user_signed_up?(current_user["email"])
      flash[:alert] = "You have already signed up for this event."
      redirect_to show_calendar_path(@calendar)
      return
    end
    
    # Create signup
    @signup = @calendar.event_signups.build(
      user_email: current_user["email"],
      user_name: current_user["name"],
      signed_up_at: Time.current
    )
    
    if @signup.save
      flash[:notice] = "Successfully signed up for #{@calendar.title}!"
    else
      flash[:alert] = @signup.errors.full_messages.join(", ")
    end
    
    redirect_to home_path
  end

  def cancel_signup
    @calendar = Calendar.find(params[:id])
    
    unless user_signed_in?
      flash[:alert] = "Please sign in to manage your event registrations."
      redirect_to root_path
      return
    end
    
    @signup = @calendar.event_signups.find_by(user_email: current_user["email"])
    
    if @signup&.destroy
      flash[:notice] = "Successfully cancelled your signup for #{@calendar.title}."
    else
      flash[:alert] = "You are not signed up for this event."
    end
    
    redirect_to home_path
  end

  def export_attendees
    @calendar = Calendar.find(params[:id])
    @attendees = @calendar.event_signups.order(:signed_up_at)
    
    respond_to do |format|
      format.csv do
        filename = "#{@calendar.title.parameterize}_attendees_#{Date.current.strftime('%Y%m%d')}.csv"
        
        csv_data = CSV.generate do |csv|
          # Event details header
          csv << ["Event Details"]
          csv << ["Title", @calendar.title]
          csv << ["Date", @calendar.event_date.strftime('%B %d, %Y at %I:%M %p')]
          csv << ["Description", @calendar.description]
          csv << ["Location", @calendar.location]
          csv << ["Category", @calendar.category]
          csv << [] # Empty row
          
          # Attendees header
          csv << ["Attendees (#{@attendees.count} registered)"]
          csv << ["Name", "Email", "Signed Up At"]
          
          # Attendee data
          @attendees.each do |attendee|
            csv << [
              attendee.user_name,
              attendee.user_email,
              attendee.signed_up_at.strftime('%B %d, %Y at %I:%M %p')
            ]
          end
        end
        
        send_data csv_data, 
                  filename: filename,
                  type: 'text/csv',
                  disposition: 'attachment'
      end
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:title, :event_date, :description, :location, :category)
  end
  #----------------------------------------------------------------------------#
end
