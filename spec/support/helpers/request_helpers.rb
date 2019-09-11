# frozen_string_literal: true

module Helpers
  module RequestHelpers
    def receive_token_credentials(user)
      post "/#{user.class.name.downcase}/auth/sign_in/",
           params: { email: user.email, password: user.password }

      response.headers.slice('client', 'access-token', 'uid')
    end
  end
end
