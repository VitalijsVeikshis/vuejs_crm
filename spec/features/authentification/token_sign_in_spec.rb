# frozen_string_literal: true

require 'rails_helper'

describe 'Token authentication', type: :request do
  describe 'POST /clients/sign_in' do
    let(:client) { create(:client) }

    context 'with valid credentials' do
      let(:credentials) { receive_token_credentials(client) }

      it 'redirects to client#index' do
        post client_session_path, params: credentials

        expect(response).to redirect_to client_root_path
      end
    end

    context 'with invalid credentials' do
      let(:options) do
        { 'uid': client.uid, 'access-token': 'wrong', 'client': 'wrong' }
      end

      it 'redirects to root' do
        post client_session_path, params: options

        expect(response).to render_template root_path
      end
    end
  end

  describe 'POST /staffs/sign_in' do
    let(:staff) { create(:staff) }

    context 'with valid credentials' do
      let(:credentials) { receive_token_credentials(staff) }

      it 'redirects to staff#index' do
        post staff_session_path, params: credentials

        expect(response).to redirect_to staff_root_path
      end
    end

    context 'with invalid credentials' do
      let(:options) do
        { 'uid': staff.uid, 'access-token': 'wrong', 'client': 'wrong' }
      end

      it 'redirects to root' do
        post staff_session_path, params: options

        expect(response).to render_template root_path
      end
    end
  end
end
