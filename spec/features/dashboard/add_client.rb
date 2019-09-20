# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can add new client', %(
  As an authenticated staff
  I'd like to be able to add new client
), js: true do
  given(:staff) { create(:staff) }

  describe 'Authenticated staff' do
    background do
      sign_in_as(staff)
      visit staff_root_path
    end

    scenario 'sees dashboard' do
      expect(page).to have_css '#dashboard'
    end

    scenario 'adds new client' do
      fill_in 'Fullname', with: 'Client Name'
      fill_in 'Phone number', with: '1234567'
      fill_in 'Email', with: 'client@email.com'
      click_on 'Save'

      within '#clients' do
        expect(page).to have_content 'Client Name'
        expect(page).to have_content '1234567'
        expect(page).to have_content 'client@email.com'
      end
    end

    describe 'does not add new client' do
      scenario 'with wrong fullname', js: true do
        fill_in 'Fullname', with: ''
        fill_in 'Phone number', with: '123456'
        fill_in 'Email', with: 'client@email.com'
        click_on 'Save'

        expect(page).to have_content "Can't be blank"
        expect(page).to have_content 'Is too short (minimum is 5 characters)'
      end

      scenario 'with wrong phone number' do
        fill_in 'Fullname', with: 'Client Name'
        fill_in 'Phone number', with: ''
        fill_in 'Email', with: 'client@email.com'
        click_on 'Save'

        expect(page).to have_content "Can't be blank"
        expect(page).to have_content 'Is not a number'
      end

      scenario 'with wrong email' do
        fill_in 'Fullname', with: 'Client Name'
        fill_in 'Phone number', with: '123456'
        fill_in 'Email', with: ''
        click_on 'Save'

        expect(page).to have_content "Can't be blank"
        expect(page).to have_content 'Is invalid'
      end
    end
  end

  describe 'Unauthenticated staff' do
    scenario 'does not see dashboard' do
      visit staff_root_path

      expect(page).to have_no_css '#dashboard'
    end
  end
end
