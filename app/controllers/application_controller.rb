# frozen_string_literal: true

class ApplicationController < ActionController::Base
  devise_group :user, contains: %i[staff client]

  def index; end
end
