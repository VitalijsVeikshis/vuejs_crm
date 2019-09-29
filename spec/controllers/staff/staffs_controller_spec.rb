# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::StaffsController, type: :controller do
  describe 'GET #current' do
    let(:staff) { create(:staff) }
    let(:request_params) { { method: :get, action: :current, format: :json } }

    before { sign_in_as(staff) }

    it 'returns current staff as json' do
      do_request(request_params)

      staff_json = StaffSerializer.new(Staff.first).serialized_json

      expect(response_json.to_json).to eq staff_json
    end

    it 'renders json with status :ok' do
      do_request(request_params)

      expect(response).to have_http_status :ok
    end
  end
end
