require 'rails_helper'

feature "user signs up" do
  # As a prospective user
  # I want to create an account
  # So that I can post items and review them

  # Acceptance Criteria:
  # must specify valid email address
  # must specify pswd and confirm pswd
  # get error message if not valid
  # if enter valid info, register account and authenticated
  before do
    visit root_path
    click_link 'Sign Up'
  end
  
  scenario 'specify valid information' do
    fill_in 'First Name', with: 'Jon'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required info not supplied' do
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'non-matching passwords' do
    fill_in 'First Name', with: 'Jon'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'newPassword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
