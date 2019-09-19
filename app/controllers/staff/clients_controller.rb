# frozen_string_literal: true

class Staff::ClientsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @clients = Client.order(created_at: :desc)
    render json: ClientSerializer.new(@clients).serialized_json
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: ClientSerializer.new(@client).serialized_json, status: :created
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
