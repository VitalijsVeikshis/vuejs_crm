# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery unless: :json_request?

  devise_group :user, contains: %i[staff client]

  def index; end

  private

  def json_request?
    request.format.json?
  end
end
