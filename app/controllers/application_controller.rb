# frozen_string_literal: true

class ApplicationController < ActionController::Base
  devise_group :user, contains: %i[staff]

  def index; end
end
