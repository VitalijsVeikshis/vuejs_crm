# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'GET #index' do
    let(:request_params) { { method: :get, action: :index } }

    it 'renders index template' do
      do_request(request_params)

      expect(response).to render_template :index
    end
  end
end
