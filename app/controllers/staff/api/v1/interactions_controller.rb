# frozen_string_literal: true

class Staff::Api::V1::InteractionsController < ApplicationController
  before_action :authenticate_staff!

  def create
    @interaction = Interaction.new(interaction_params)
    if @interaction.save
      render json: @interaction.as_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  private

  def interaction_params
    params.require(:interaction).permit(:client_id, :organization_id)
  end

  def errors_json
    @interaction
      .errors
      .as_json
  end
end
