# frozen_string_literal: true

class Client::LandingController < ApplicationController
  layout 'client'

  def index
    if current_client
      render :index
    else
      redirect_to root_path
    end
  end
end
