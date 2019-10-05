# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::Api::V1::StaffsController, type: :controller do
  let(:staff) { create(:staff) }

  before { sign_in_as(staff) }

  describe 'GET #current' do
    let(:request_params) { { method: :get, action: :current, format: :json } }

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

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:options) { { staff: attributes_for(:staff) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'saves a new staff in the database' do
        expect do
          do_request(request_params)
        end.to change(Staff, :count).by(1)
      end

      it 'returns created staff as json' do
        do_request(request_params)

        staff_json = StaffSerializer.new(Staff.last).serialized_json

        expect(response_json.to_json).to eq staff_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:options) { { staff: attributes_for(:staff, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'does not save new staff in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Staff, :count)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('email'))
          .to eq ['не может быть пустым', 'имеет неверное значение']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'POST #validate' do
    let(:options) { { staff: { email: 'staff@email.com' } } }
    let(:request_params) { { method: :post, action: :validate, options: options, format: :json } }

    context 'with valid attribute' do
      it 'returns json with params' do
        do_request(request_params)

        expect(response_json).to eq options.dig(:staff).as_json
      end

      it 'renders json with status :ok' do
        do_request(request_params)

        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attribute' do
      let!(:staff) { create(:staff, email: 'staff@email.com') }

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('email')).to eq ['уже существует']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:staff) { create(:staff) }
    let(:options) { { id: staff } }
    let(:request_params) { { method: :delete, action: :destroy, options: options, format: :json } }

    it 'deletes staff' do
      expect do
        do_request(request_params)
      end.to change(Staff, :count).by(-1)
    end

    it 'renders response with status :no_content' do
      do_request(request_params)

      expect(response).to have_http_status :no_content
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:staff) { create(:staff) }
      let(:options) { { id: staff, staff: { email: 'new@email.com' } } }
      let(:request_params) { { method: :patch, action: :update, options: options, format: :json } }

      before { do_request(request_params) }

      it 'changes staff attribues' do
        staff.reload

        expect(staff.email).to eq 'new@email.com'
      end

      it 'renders json with status :created' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'with invalid attributes' do
      let(:staff) { create(:staff) }
      let(:options) { { id: staff, staff: attributes_for(:staff, :invalid) } }
      let(:request_params) { { method: :patch, action: :update, options: options, format: :json } }

      it 'does not change staff attributes' do
        expect do
          do_request(request_params)
        end.not_to change(staff, :email)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('email'))
          .to eq ['не может быть пустым', 'имеет неверное значение']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #index' do
    let(:staffs) { create_list(:staff, 3) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'returns staffs list' do
      do_request(request_params)

      staffs_json = StaffSerializer.new(Staff.all).serialized_json

      expect(response_json.to_json).to eq staffs_json
    end
  end

  describe 'PATCH #reset_password' do
    let!(:staff) { create(:staff) }
    let(:options) { { id: staff } }
    let(:request_params) { { method: :patch, action: :reset_password, options: options, format: :json } }

    it 'changes staff password' do
      old_encrypted_password = staff.encrypted_password
      do_request(request_params)
      staff.reload

      expect(staff.encrypted_password).not_to eq old_encrypted_password
    end

    it 'sends to staff email with password reset instructions' do
      expect do
        do_request(request_params)
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
