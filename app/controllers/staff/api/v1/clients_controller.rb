# frozen_string_literal: true

class Staff::Api::V1::ClientsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_client, only: %i[destroy update reset_password]

  def index
    @clients = Client.order(created_at: :desc)
    render json: ClientSerializer.new(@clients).serialized_json
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: ClientSerializer.new(@client).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @client = Client.new(client_params)
    @client.valid?

    if errors_json.empty?
      render json: client_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    if @client.destroy
      head :no_content
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      head :no_content
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def reset_password
    @client.reset_password!
    @client.send_reset_password_instructions

    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:fullname, :phone, :email)
  end

  def errors_json
    @client
      .errors
      .as_json
      .as_json(only: client_params.keys.map(&:to_sym))
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
