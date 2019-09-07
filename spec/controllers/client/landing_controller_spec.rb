# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::LandingController, type: :controller do
  describe 'GET #index' do
    context 'when user is client' do
      let(:client) { create(:client) }
      let(:request_params) { { method: :get, action: :index } }

      before { sign_in_as(client) }

      it 'renders index template' do
        do_request(request_params)

        expect(response).to render_template :index
      end

      it 'renders client layout' do
        do_request(request_params)

        expect(response).to render_template(layout: :client)
      end
    end

    context 'when user is not client' do
      let(:request_params) { { method: :get, action: :index } }

      it 'redirects to root' do
        do_request(request_params)

        expect(response).to redirect_to root_path
      end
    end
  end
end
