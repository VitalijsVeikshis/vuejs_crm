# frozen_string_literal: true

class Staff::LandingController < ApplicationController
  layout 'staff'

  def index
    if current_staff
      render :index
    else
      redirect_to root_path
    end
  end
end
