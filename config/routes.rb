# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  
  # Dashboard route
  get '/dashboard', to: 'dashboards#show', as: :dashboard

  devise_scope :admin do
    get 'admins/sign_in',  to: 'admins/sessions#new',     as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # your custom collection page remains
  get '/books/home', to: 'books#home', as: :home

  # use resources for the standard parts whose helper names you already use
  resources :books, only: %i[new create edit]

  # keep your custom helper names for the others
  get    '/books/:id',             to: 'books#show',    as: :show_book
  patch  '/books/:id',             to: 'books#update',  as: :update_book
  delete '/books/:id',             to: 'books#destroy', as: :destroy_book

  # your confirm page
  get '/books/:id/delete_book', to: 'books#delete', as: :delete_book
end
