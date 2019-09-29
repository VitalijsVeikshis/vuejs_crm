# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can add new organization', %(
  As an authenticated staff
  I'd like to be able to add new organization
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

    scenario 'adds new organization' do
      fill_in 'Название', with: 'Organization Name'

      find('#formOfOwnership').click
      within '.q-virtual-scroll__content' do
        find('.q-item__label', text: 'ИП').click
      end

      fill_in 'ИНН', with: '123456789123'
      fill_in 'ОГРН', with: '1234567891234'

      find('#addOrganizationBtn').click

      within '#newOrganization' do
        expect(page).to have_no_content 'Organization Name'
        expect(page).to have_no_content 'ИП'
        expect(page).to have_no_content '123456789123'
        expect(page).to have_no_content '1234567891234'
      end

      within '#organizations' do
        expect(page).to have_content 'Organization Name'
        expect(page).to have_content 'ИП'
        expect(page).to have_content '123456789123'
        expect(page).to have_content '1234567891234'
      end
    end

    describe 'does not add new organization' do
      scenario 'with empty attributes', js: true do
        find('#addOrganizationBtn').click

        within '#name' do
          expect(page).to have_content "Can't be blank"
        end

        within '#formOfOwnershipInput' do
          expect(page).to have_content "Can't be blank"
        end

        within '#inn' do
          expect(page).to have_content "Can't be blank"
        end

        within '#ogrn' do
          expect(page).to have_content "Can't be blank"
        end
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
