# frozen_string_literal: true

class Staff::Api::V1::StaffsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_staff, only: %i[destroy update reset_password]

  def current
    render json: StaffSerializer.new(current_user).serialized_json
  end

  def index
    @staffs = Staff.order(created_at: :desc)
    render json: StaffSerializer.new(@staffs).serialized_json
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      render json: StaffSerializer.new(@staff).serialized_json,
             status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @staff = Staff.new(staff_params)
    @staff.valid?

    if errors_json.empty?
      render json: staff_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    if @staff.destroy
      head :no_content
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    if @staff.update(staff_params)
      head :no_content
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def reset_password
    @staff.reset_password!
    @staff.send_reset_password_instructions

    head :no_content
  end

  private

  def staff_params
    params.require(:staff).permit(:email)
  end

  def errors_json
    @staff
      .errors
      .as_json
      .as_json(only: staff_params.keys.map(&:to_sym))
  end

  def set_staff
    @staff = Staff.find(params[:id])
  end
end
