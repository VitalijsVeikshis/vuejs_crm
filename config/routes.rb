# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :clients, controllers: { sessions: 'users/sessions' }
  devise_for :staffs, controllers: { sessions: 'users/sessions' }

  root 'application#index'

  namespace :staff do
    root 'landing#index'
  end

  namespace :client do
    root 'landing#index'
  end
end
