# frozen_string_literal: true

module Helpers
  module ControllerHelpers
    def sign_in_as(user)
      case user.class.name
      when 'Staff'
        @request.env['devise.mapping'] = Devise.mappings[:staff]
      when 'Client'
        @request.env['devise.mapping'] = Devise.mappings[:client]
      end

      sign_in user
    end

    def do_request(request_params)
      send request_params.dig(:method),
           request_params.dig(:action),
           params: request_params.dig(:options)
    end

    def response_json
      @response_json ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end
