# frozen_string_literal: true

class Client::LandingController < ApplicationController
  layout 'client'

  acts_as_token_authentication_handler_for Client, if: :json_request?
  before_action :authenticate_client!, unless: :json_request?

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Client!' }
      end
    end
  end
end
