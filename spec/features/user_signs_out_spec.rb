require 'rails_helper'

feature "user signs out" do
  # As an authenticated user
  # I want to sign out
  # So that no one else can post items or reviews on my behalf

  # Acceptance Criteria:
  # if logged in, can sign out

  scenario 'signs in with valid email and password, then signs out' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')

    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_content('Log In')
  end
end
