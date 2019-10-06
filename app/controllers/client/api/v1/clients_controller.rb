# frozen_string_literal: true

class Client::Api::V1::ClientsController < ApplicationController
  before_action :authenticate_client!

  def current
    render json: ClientSerializer.new(current_user).serialized_json
  end
end
