# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::ClientsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:staff) { create(:staff) }
      let(:options) { { client: attributes_for(:client) } }
      let(:request_params) { { method: :post, action: :create, options: options } }

      before { sign_in_as(staff) }

      it 'saves a new client in the database' do
        expect do
          do_request(request_params)
        end.to change(Client, :count).by(1)
      end

      it 'returns created client as json' do
        do_request(request_params)

        expect(response_json).to eq Client.first.as_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:staff) { create(:staff) }
      let(:options) { { client: attributes_for(:client, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options } }

      before { sign_in_as(staff) }

      it 'does not save new client in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Client, :count)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('email')).to eq ["can't be blank", 'is invalid']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #index' do
    let(:staff) { create(:staff) }
    let!(:clients) { create_list(:client, 3) }
    let(:request_params) { { method: :get, action: :index } }

    before { sign_in_as(staff) }

    it 'returns clients list' do
      do_request(request_params)

      clients.each do |client|
        expect(response_json).to include client.as_json
      end
    end
  end
end
