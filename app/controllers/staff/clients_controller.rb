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
end
