require 'rails_helper'

feature "user deletes account" do
  # As an authenticated user
  # I want to delete my account
  # So that my information is no longer retained by the app

  # Acceptance Criteria:
  # if confirm cancel account, profile deleted from record
  # if
  #

  scenario 'an existing user successfully deletes account' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')

    click_link 'Edit Profile'
    click_button 'Cancel my account'
    
    expect(page).to have_content('Your account has been successfully cancelled')
  end
end
