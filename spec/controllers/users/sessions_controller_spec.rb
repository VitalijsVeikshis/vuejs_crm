# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'POST #create' do
    context 'when json request' do
      context 'when sign in staff' do
        let(:user) { create(:staff) }

        it_behaves_like 'API Authenticable', :staff, :json
      end

      context 'when sign in client' do
        let(:user) { create(:client) }

        it_behaves_like 'API Authenticable', :client, :json
      end
    end
  end
end
