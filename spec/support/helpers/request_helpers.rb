# frozen_string_literal: true

module Helpers
  module RequestHelpers
    def token_credentials_for(user)
      user.create_new_auth_token.slice('client', 'access-token', 'uid')
    end
  end
end
