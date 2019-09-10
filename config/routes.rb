# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :clients
  devise_for :staffs

  root 'application#index'

  namespace :staff do
    root 'landing#index'
  end

  namespace :client do
    root 'landing#index'
  end
end
