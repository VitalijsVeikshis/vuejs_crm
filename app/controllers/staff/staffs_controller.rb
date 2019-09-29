# frozen_string_literal: true

class Staff::StaffsController < ApplicationController
  before_action :authenticate_staff!

  def current
    render json: StaffSerializer.new(current_user).serialized_json
  end
end
