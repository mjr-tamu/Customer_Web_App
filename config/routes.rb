# frozen_string_literal: true

Rails.application.routes.draw do
  get "admin_management/index"
  get "admin_management/create_admin"
  get "admin_management/remove_admin"
  root 'calendars#home'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  
  # Custom OAuth route to handle initiation
  get '/admins/auth/google_oauth2/init', to: 'admins/omniauth_callbacks#init_oauth', as: :init_google_oauth
  
  # Dashboard route
  get '/dashboard', to: 'dashboards#show', as: :dashboard

  devise_scope :admin do
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # your custom collection page remains
  get '/calendars/home(/:date)', to: 'calendars#home', as: :home

  # use resources for the standard parts whose helper names you already use
  resources :calendars, only: %i[new create edit]

  # keep your custom helper names for the others
  get    '/calendars/:id',             to: 'calendars#show',    as: :show_calendar
  patch  '/calendars/:id',             to: 'calendars#update',  as: :update_calendar
  delete '/calendars/:id',             to: 'calendars#destroy', as: :destroy_calendar

  # your confirm page
  get '/calendars/:id/delete_calendar', to: 'calendars#delete', as: :delete_calendar

  # Admin management routes
  get '/admin_management', to: 'admin_management#index', as: :admin_management
  post '/admin_management/create_admin', to: 'admin_management#create_admin', as: :create_admin
  delete '/admin_management/remove_admin/:id', to: 'admin_management#remove_admin', as: :remove_admin

  # User sign out route
  delete '/sign_out_user', to: 'calendars#sign_out_user', as: :sign_out_user

  # About page route
  get '/about', to: 'calendars#about', as: :about

  # Event signup routes
  post '/calendars/:id/signup', to: 'calendars#signup', as: :signup_calendar
  delete '/calendars/:id/signup', to: 'calendars#cancel_signup', as: :cancel_signup_calendar
  get '/calendars/:id/export_attendees', to: 'calendars#export_attendees', as: :export_attendees_calendar, defaults: { format: 'csv' }
end
