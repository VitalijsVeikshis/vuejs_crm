# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', %(
  As an unauthenticated user
  I'd like to be able to sign in
), js: true do
  given(:staff) { create(:staff) }
  given(:client) { create(:client) }

  describe 'Registered' do
    scenario 'staff sign in' do
      visit new_staff_session_path

      fill_in 'Email', with: staff.email
      fill_in 'Password', with: staff.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Hello Staff!'
    end

    scenario 'client sign in' do
      visit new_client_session_path

      fill_in 'Email', with: client.email
      fill_in 'Password', with: client.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Hello Client!'
    end
  end

  describe 'Unregistred' do
    scenario 'staff does not sign in' do
      visit new_staff_session_path

      fill_in 'Email', with: 'unregistred@staff.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
      expect(page).to have_no_content 'Hello Staff!'
    end

    scenario 'client does not sign in' do
      visit new_client_session_path

      fill_in 'Email', with: 'unregistred@client.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
      expect(page).to have_no_content 'Hello Client!'
    end
  end

  describe 'Redirect to root' do
    scenario 'if unauthenticated client' do
      sign_in_as(staff)

      visit client_root_path

      expect(page).to have_no_content 'Hello Client!'
    end

    scenario 'if unauthenticated staff' do
      sign_in_as(client)

      visit staff_root_path

      expect(page).to have_no_content 'Hello Staff!'
    end
  end
end
