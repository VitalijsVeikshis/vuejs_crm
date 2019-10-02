# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::ClientsController, type: :controller do
  let(:staff) { create(:staff) }

  before { sign_in_as(staff) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:options) { { client: attributes_for(:client) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'saves a new client in the database' do
        expect do
          do_request(request_params)
        end.to change(Client, :count).by(1)
      end

      it 'returns created client as json' do
        do_request(request_params)

        client_json = ClientSerializer.new(Client.last).serialized_json

        expect(response_json.to_json).to eq client_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:options) { { client: attributes_for(:client, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'does not save new client in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Client, :count)
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
    let(:clients) { create_list(:client, 3) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'returns clients list' do
      do_request(request_params)

      clients_json = ClientSerializer.new(Client.all).serialized_json

      expect(response_json.to_json).to eq clients_json
    end
  end

  describe 'POST #validate' do
    let(:options) { { client: { email: 'client@email.com' } } }
    let(:request_params) { { method: :post, action: :validate, options: options, format: :json } }

    before { sign_in_as(staff) }

    context 'with valid attribute' do
      it 'returns json with params' do
        do_request(request_params)

        expect(response_json).to eq options.dig(:client).as_json
      end

      it 'renders json with status :ok' do
        do_request(request_params)

        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attribute' do
      let!(:client) { create(:client, email: 'client@email.com') }

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
    let!(:client) { create(:client) }
    let(:options) { { id: client } }
    let(:request_params) { { method: :delete, action: :destroy, options: options, format: :json } }

    it 'deletes staff' do
      expect do
        do_request(request_params)
      end.to change(Client, :count).by(-1)
    end

    it 'renders response with status :no_content' do
      do_request(request_params)

      expect(response).to have_http_status :no_content
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:client) { create(:client) }
      let(:options) { { id: client, client: { email: 'new@email.com' } } }
      let(:request_params) { { method: :patch, action: :update, options: options, format: :json } }

      before { do_request(request_params) }

      it 'changes client attribues' do
        client.reload

        expect(client.email).to eq 'new@email.com'
      end

      it 'renders json with status :created' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'with invalid attributes' do
      let(:client) { create(:client) }
      let(:options) { { id: client, client: attributes_for(:client, :invalid) } }
      let(:request_params) { { method: :patch, action: :update, options: options, format: :json } }

      it 'does not change client attributes' do
        expect do
          do_request(request_params)
        end.not_to change(client, :email)
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

  describe 'PATCH #reset_password' do
    let!(:client) { create(:client) }
    let(:options) { { id: client } }
    let(:request_params) { { method: :patch, action: :reset_password, options: options, format: :json } }

    it 'changes client password' do
      old_encrypted_password = client.encrypted_password
      do_request(request_params)
      client.reload

      expect(client.encrypted_password).not_to eq old_encrypted_password
    end

    it 'sends to client email with password reset instructions' do
      expect do
        do_request(request_params)
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
