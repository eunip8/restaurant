require 'rails_helper'

feature "user updates info" do
  # As an authenticated user
  # I want to update my information
  # So that I can keep my profile up to date

  # Acceptance Criteria:
  # if enter new email, successfully changed
  # if enter matching new passwords, successfully changed
  # if enter mismatched new passwords, get error
  # if not confirm current password, cannot change password, get error

  before do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    click_link 'Edit Profile'
  end

  scenario 'change email' do
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'change password successfully' do
    fill_in 'Password', with: 'newPassword'
    fill_in 'Password confirmation', with: 'newPassword'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'mismatching new password, get error' do
    fill_in 'Password', with: 'newPassword'
    fill_in 'Password confirmation', with: 'wrongPassword'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'supply incorrect current pswd, get error' do
    fill_in 'Password', with: 'newPassword'
    fill_in 'Password confirmation', with: 'newPassword'
    fill_in 'Current password', with: 'somethingwrong'
    click_button 'Update'

    expect(page).to have_content('Current password is invalid')
  end
end
