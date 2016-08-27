require 'rails_helper'

feature "user signs in" do
  # As an unauthenticated user
  # I want to sign in
  # So that I can post items and review them

  # Acceptance Criteria:
  # if enter valid email/pswd, authenticated and gain access
  # if invalid email/pswd, remain unathenticated
  # if already signed in, can't sign in again

  scenario 'an existing user enters valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'non-existent email and password entered' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(page).to_not have_content('Signed in successfully')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Invalid Email or password')
  end


  scenario 'existing email with wrong password denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Log In'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Log In')

    visit new_user_session_path

    expect(page).to have_content('You are already signed in.')
  end
end
