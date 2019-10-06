# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::Api::V1::EquipmentsController, type: :controller do
  let(:staff) { create(:staff) }
  let(:organization) { create(:organization) }

  before { sign_in_as(staff) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:options) { { organization_id: organization, equipment: attributes_for(:equipment) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'saves a new equipment in the database' do
        expect do
          do_request(request_params)
        end.to change(Equipment, :count).by(1)
      end

      it 'returns created equipment as json' do
        do_request(request_params)

        equipment_json = EquipmentSerializer.new(Equipment.last).serialized_json

        expect(response_json.to_json).to eq equipment_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:options) { { organization_id: organization, equipment: attributes_for(:equipment, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'does not save new equipment in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Equipment, :count)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('title'))
          .to eq ['не может быть пустым']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'POST #validate' do
    context 'with valid attribute' do
      let(:options) { { organization_id: organization, equipment: attributes_for(:equipment) } }
      let(:request_params) { { method: :post, action: :validate, options: options, format: :json } }

      it 'returns json with params' do
        do_request(request_params)

        expect(response_json).to eq options.dig(:equipment).as_json
      end

      it 'renders json with status :ok' do
        do_request(request_params)

        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attribute' do
      let(:options) { { organization_id: organization, equipment: attributes_for(:equipment, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('title')).to eq ['не может быть пустым']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
