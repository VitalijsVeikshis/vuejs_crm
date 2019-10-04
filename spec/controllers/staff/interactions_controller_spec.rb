# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::Api::V1::InteractionsController, type: :controller do
  let(:staff) { create(:staff) }

  before { sign_in_as(staff) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:options) { { interaction: attributes_for(:interaction) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'saves a new interaction in the database' do
        expect do
          do_request(request_params)
        end.to change(Interaction, :count).by(1)
      end

      it 'returns created interaction as json' do
        do_request(request_params)

        expect(response_json.to_json).to eq Interaction.last.to_json
      end

      it 'renders json with status :created' do
        do_request(request_params)

        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      let(:options) { { interaction: attributes_for(:interaction, :invalid) } }
      let(:request_params) { { method: :post, action: :create, options: options, format: :json } }

      it 'does not save new interaction in the database' do
        expect do
          do_request(request_params)
        end.not_to change(Interaction, :count)
      end

      it 'returns errors as json' do
        do_request(request_params)

        expect(response_json.dig('client'))
          .to eq ['не может отсутствовать']
      end

      it 'renders json with status :unprocessable_entity' do
        do_request(request_params)

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end