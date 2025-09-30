# frozen_string_literal: true

Rails.application.routes.draw do
  root 'calendars#home'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  
  # Dashboard route
  get '/dashboard', to: 'dashboards#show', as: :dashboard

  devise_scope :admin do
    get 'admins/sign_in',  to: 'admins/sessions#new',     as: :new_admin_session
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
end
