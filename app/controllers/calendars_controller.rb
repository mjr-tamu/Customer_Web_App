# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :authenticate_admin!, except: [:home, :show]

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
  end

  def show
    @calendar = Calendar.find(params[:id])
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
    redirect_to new_admin_session_path
  end

  private

  def calendar_params
    params.require(:calendar).permit(:title, :event_date, :description, :location, :category)
  end
  #----------------------------------------------------------------------------#
end
