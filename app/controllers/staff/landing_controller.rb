# frozen_string_literal: true

class Staff::LandingController < ApplicationController
  layout 'staff'

  before_action :authenticate_staff!

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Staff!' }
      end
    end
  end
end
