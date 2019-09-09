# frozen_string_literal: true

class Staff::LandingController < ApplicationController
  layout 'staff'

  acts_as_token_authentication_handler_for Staff, if: :json_request?
  before_action :authenticate_staff!, unless: :json_request?

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Staff!' }
      end
    end
  end
end
