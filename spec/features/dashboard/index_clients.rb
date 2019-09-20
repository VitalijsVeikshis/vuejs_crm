# frozen_string_literal: true

require 'rails_helper'

feature 'Staff see clients list', %(
  As an authenticated staff
  I'd like to be able to see clients list
), js: true do
  given(:staff) { create(:staff) }
  given(:clients) { create_list(:client, 3) }

  describe 'Authenticated staff' do
    background do
      sign_in_as(staff)
      visit staff_root_path
    end

    scenario 'sees clients list' do
      within '#clients' do
        expect(page).to have_content clients.first.fullname
        expect(page).to have_content clients.first.phone
        expect(page).to have_content clients.first.email
      end
    end
  end

  describe 'Unauthenticated staff' do
    scenario 'does not see clients list' do
      visit staff_root_path

      expect(page).to have_no_css '#clients'
    end
  end
end
