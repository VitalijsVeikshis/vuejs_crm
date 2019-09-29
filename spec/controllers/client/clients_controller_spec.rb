# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::ClientsController, type: :controller do
  describe 'GET #current' do
    let(:client) { create(:client) }
    let(:request_params) { { method: :get, action: :current, format: :json } }

    before { sign_in_as(client) }

    it 'returns current client as json' do
      do_request(request_params)

      client_json = ClientSerializer.new(Client.first).serialized_json

      expect(response_json.to_json).to eq client_json
    end

    it 'renders json with status :ok' do
      do_request(request_params)

      expect(response).to have_http_status :ok
    end
  end
end
