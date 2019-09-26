# frozen_string_literal: true

require 'rails_helper'

feature 'Staff see organizations list', %(
  As an authenticated staff
  I'd like to be able to see organizations list
), js: true do
  given(:staff) { create(:staff) }
  given!(:organizations) { create_list(:organization, 3) }

  describe 'Authenticated staff' do
    background do
      sign_in_as(staff)
      visit staff_root_path
    end

    scenario 'sees organizations list' do
      within '#organizations' do
        expect(page).to have_content organizations.first.name
        expect(page).to have_content 'ООО'
        expect(page).to have_content organizations.first.inn
        expect(page).to have_content organizations.first.ogrn
      end
    end
  end

  describe 'Unauthenticated staff' do
    scenario 'does not see organizations list' do
      visit staff_root_path

      expect(page).to have_no_css '#organizations'
    end
  end
end
