# frozen_string_literal: true

class Staff::Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_organization, only: %i[destroy]

  def index
    @organizations = Organization.order(created_at: :desc)
    render json: OrganizationSerializer.new(@organizations).serialized_json
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: OrganizationSerializer.new(@organization).serialized_json,
             status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy

    head :no_content
  end

  def validate
    @organization = Organization.new(organization_params)
    @organization.valid?

    if errors_json.empty?
      render json: organization_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :form_of_ownership, :inn, :ogrn)
  end

  def errors_json
    @organization
      .errors
      .as_json
      .as_json(only: organization_params.keys.map(&:to_sym))
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
