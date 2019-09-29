# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::OrganizationsController, type: :controller do
  let(:staff) { create(:staff) }

  before { sign_in_as(staff) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:options) { { organization: attributes_for(:organization) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'saves a new organization in the database' do
        expect do
          do_request(request_params)
        end.to change(Organization, :count).by(1)
      end

      it 'returns created organization as json' do
        do_request(request_params)

        organization_json = OrganizationSerializer.new(Organization.last).serialized_json

        expect(response_json.to_json).to eq organization_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:options) { { organization: attributes_for(:organization, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'does not save new organization in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Organization, :count)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('name')).to eq ["can't be blank"]
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #index' do
    let(:organizations) { create_list(:organization, 3) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'returns organizations list' do
      do_request(request_params)

      organizations_json = OrganizationSerializer.new(Organization.all).serialized_json

      expect(response_json.to_json).to eq organizations_json
    end
  end

  describe 'DELETE #destroy' do
    let!(:organization) { create(:organization) }
    let(:options) { { id: organization } }
    let(:request_params) { { method: :delete, action: :destroy, options: options, format: :json } }

    it 'deletes organization' do
      expect do
        do_request(request_params)
      end.to change(Organization, :count).by(-1)
    end

    it 'renders response with status :no_content' do
      do_request(request_params)

      expect(response).to have_http_status :no_content
    end
  end

  describe 'POST #validate' do
    let(:options) { { organization: { name: 'Organization name' } } }
    let(:request_params) { { method: :post, action: :validate, options: options, format: :json } }

    context 'with valid attribute' do
      it 'returns json with params' do
        do_request(request_params)

        expect(response_json).to eq options.dig(:organization).as_json
      end

      it 'renders json with status :ok' do
        do_request(request_params)

        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attribute' do
      let!(:organization) { create(:organization, name: 'Organization name') }

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('name')).to eq ['has already been taken']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
