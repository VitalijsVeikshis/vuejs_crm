shared_examples_for 'API Authenticable' do |user_type, request_format|
  before { @request.env['devise.mapping'] = Devise.mappings[user_type] }

  context 'with valid credentials' do
    let(:options) do
      { user_type => { email: user.email, password: user.password },
        format: request_format }
    end
    let(:request_params) { { method: :post, action: :create, options: options } }

    before { do_request(request_params) }

    it 'returns seccess true' do
      expect(response_json.dig(:success)).to eq true
    end

    it 'returns authentication_token' do
      expect(response_json.dig(:auth_token)).to eq user.authentication_token
    end

    it 'returns user email' do
      expect(response_json.dig(:email)).to eq user.email
    end
  end

  context 'with invalid credentials' do
    let(:options) do
      { user_type => { email: 'wrong@test.email', password: 'wrong_password' },
        format: request_format }
    end
    let(:request_params) { { method: :post, action: :create, options: options } }

    it 'returns error' do
      error_message = 'Invalid Email or password.'
      do_request(request_params)

      expect(response_json.dig(:error)).to eq error_message
    end
  end
end
