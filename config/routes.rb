# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :staffs, skip: %i[registrations]
  devise_for :clients, skip: %i[registrations]

  root 'application#index'

  namespace :staff do
    root 'landing#index'
    mount_devise_token_auth_for 'Staff', at: 'auth', skip: %i[registrations]

    namespace :api do
      namespace :v1 do
        resources :clients, only: %i[index create destroy update], shallow: true do
          collection do
            post :validate
          end

          member do
            patch :reset_password
          end
        end

        resources :organizations, only: %i[index create destroy], shallow: true do
          collection do
            post :validate
            post :suggestions
          end
        end

        resources :staffs, only: %i[index create destroy update], shallow: true do
          collection do
            post :validate
          end

          member do
            patch :reset_password
          end
        end

        get :current, to: 'staffs#current'
      end
    end

    get '/*slug', to: 'landing#index'
  end

  namespace :client do
    root 'landing#index'
    mount_devise_token_auth_for 'Client', at: 'auth', skip: %i[registrations]

    namespace :api do
      namespace :v1 do
        get :current, to: 'clients#current'
      end
    end

    get '/*slug', to: 'landing#index'
  end
end
