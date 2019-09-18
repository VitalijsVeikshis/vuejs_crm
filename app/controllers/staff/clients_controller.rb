# frozen_string_literal: true

class Staff::ClientsController < ApplicationController
  def index
    render json: Client.order(created_at: :desc).as_json
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client.as_json, status: :created
    else
      render_errors_json
    end
  end

  private

  def client_params
    params.require(:client).permit(:fullname, :phone, :email)
  end

  def render_errors_json
    render json: @client.errors, status: :unprocessable_entity
  end
end
