# frozen_string_literal: true

class Client::LandingController < ApplicationController
  layout 'client'

  before_action :authenticate_client!

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Client!' }
      end
    end
  end
end
