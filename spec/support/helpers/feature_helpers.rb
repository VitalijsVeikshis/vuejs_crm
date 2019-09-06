# frozen_string_literal: true

module Helpers
  module FeatureHelpers
    def sign_in_as(user)
      case user.class.name
      when 'Staff'
        visit new_staff_session_path
      when 'Client'
        visit new_client_session_path
      end

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
  end
end
