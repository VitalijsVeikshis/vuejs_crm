# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::LandingController, type: :controller do
  describe 'GET #index' do
    context 'when user is client' do
      let(:client) { create(:client) }

      context 'when cookie authentication' do
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

      context 'when token authentication' do
        let(:options) do
          { client_email: client.email, client_token: client.authentication_token,
            format: :json }
        end
        let(:request_params) { { method: :get, action: :index, options: options } }

        it_behaves_like 'API success request', :ok
      end
    end

    context 'when user is not client' do
      let(:request_params) { { method: :get, action: :index } }

      context 'when cookie authentication' do
        it 'redirects to root' do
          do_request(request_params)

          expect(response).to redirect_to root_path
        end
      end

      context 'when token authentication' do
        let(:options) do
          { client_email: 'wrong@test.email', client_token: 'wrong_token',
            format: :json }
        end
        let(:request_params) { { method: :get, action: :index, options: options } }

        it_behaves_like 'API failure request', :unauthorized
      end
    end
  end
end
