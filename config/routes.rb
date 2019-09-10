# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :clients, skip: %i[registrations]
  devise_for :staffs, skip: %i[registrations]

  root 'application#index'

  namespace :staff do
    root 'landing#index'
  end

  namespace :client do
    root 'landing#index'
  end
end
