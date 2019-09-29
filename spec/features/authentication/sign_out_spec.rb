# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', %(
  As an authenticated user
  I'd like to be able to sign out
), js: true do
  describe 'Staff' do
    given(:staff) { create(:staff) }

    background { sign_in_as(staff) }

    scenario 'signed out from application#index' do
      visit root_path

      find('#logoutBtn').click

      expect(page).to have_content 'Signed out successfully.'
    end

    scenario 'signed out from staff/landing#index' do
      visit staff_root_path

      find('#logoutBtn').click

      expect(page).to have_content 'Signed out successfully.'
    end
  end

  describe 'Client' do
    given(:client) { create(:client) }

    background { sign_in_as(client) }

    scenario 'signed out from application#index' do
      visit root_path

      find('#logoutBtn').click

      expect(page).to have_content 'Signed out successfully.'
    end

    scenario 'signed out from client/landing#index' do
      visit client_root_path

      find('#logoutBtn').click

      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
