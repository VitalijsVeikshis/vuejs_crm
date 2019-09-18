# frozen_string_literal: true

module Helpers
  module ControllerHelpers
    def sign_in_as(user)
      user_type = user.class.name.downcase.to_sym
      @request.env['devise.mapping'] = Devise.mappings[user_type]

      sign_in user
    end

    def do_request(request_params)
      send request_params.dig(:method),
           request_params.dig(:action),
           params: request_params.dig(:options)
    end

    def response_json
      @response_json ||= JSON.parse(response.body)
    end
  end
end
