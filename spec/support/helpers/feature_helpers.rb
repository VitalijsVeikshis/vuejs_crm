# frozen_string_literal: true

module Helpers
  module FeatureHelpers
    def sign_in_as(user)
      user_type = user.class.name.downcase.pluralize
      visit "/#{user_type}/sign_in"

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
  end
end
