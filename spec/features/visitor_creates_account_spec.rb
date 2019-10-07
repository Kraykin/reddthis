require 'rails_helper'

feature 'Visitor create account' do
  given(:user) { attributes_for(:user) }

  scenario 'visitor sign up' do
    visit root_path
    click_link 'Signup'

    fill_in :user_username,              with: user[:username]
    fill_in :user_email,                 with: user[:email]
    fill_in :user_password,              with: user[:password]
    fill_in :user_password_confirmation, with: user[:password_confirmation]

    click_on 'Sign up'

    expect(page).to have_text 'A message with a confirmation link'
  end
end
