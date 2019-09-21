# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :staffs, skip: %i[registrations]
  devise_for :clients, skip: %i[registrations]

  root 'application#index'

  namespace :staff do
    root 'landing#index'
    mount_devise_token_auth_for 'Staff', at: 'auth', skip: %i[registrations]

    resources :clients, only: %i[index create], shallow: true do
      collection do
        post :validate
      end
    end
  end

  namespace :client do
    root 'landing#index'
    mount_devise_token_auth_for 'Client', at: 'auth', skip: %i[registrations]

    get :current, to: 'clients#current'
  end
end
